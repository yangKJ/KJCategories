//
//  KJShadowView.swift
//  KJCategories
//
//  Created by 77。 on 2021/12/10.
//  https://github.com/YangKJ/KJCategories

import UIKit
import Accelerate.vImage

// https://juejin.cn/post/7011309826592473125

@objc public enum ImageShadowType: Int {
    case inner, outer, meanwhile
}

@objcMembers
public class KJShadowView: UIImageView {
    
    public var shadowType: ImageShadowType? {
        didSet {
            self.changeShadow()
        }
    }
    /// Smooth shadow corners
    public var round: Bool? {
        didSet {
            self.changeShadow()
        }
    }
    
    private var fuzzy: CGFloat = 0.1
    private var opacity: CGFloat = 0.8
    private var extend: CGFloat = 25
    private var color: UIColor = .black
    private var outsidePath: UIBezierPath?
    private var drawBounds: CGRect = .zero
    private lazy var displayView: UIImageView = UIImageView.init()
    
    public init(image: UIImage, path: UIBezierPath? = nil, type: ImageShadowType = .meanwhile) {
        super.init(frame: .zero)
        self.round = false
        self.outsidePath = path
        self.shadowType = type
        self.image = image
        self.displayView.clipsToBounds = false
        self.displayView.contentMode = .scaleAspectFit
        self.displayView.isUserInteractionEnabled = false
        self.addSubview(self.displayView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.outsidePath = UIBezierPath(rect: self.frame)
        self.drawBounds = self.superview!.bounds
        self.displayView.frame = CGRect(x: -self.frame.origin.x,
                                        y: -self.frame.origin.y,
                                        width: self.superview!.frame.size.width,
                                        height: self.superview!.frame.size.height)
        self.changeShadow()
    }
    
    /// Modify the inner and outer shadow parameters
    /// - Parameters:
    ///   - fuzzy: Degree of ambiguity, `0-1`
    ///   - extend: Path width
    ///   - color: Path color
    ///   - opacity: Shadow transparency, `0 - 1`
    public func changeShadow(color: UIColor? = nil,
                             fuzzy: CGFloat? = nil,
                             extend: CGFloat? = nil,
                             opacity: CGFloat? = nil) {
        if let opacity = opacity {
            self.opacity = opacity
        }
        if let fuzzy = fuzzy {
            self.fuzzy = fuzzy
        }
        if let extend = extend {
            self.extend = extend
        }
        if let color = color {
            self.color = color
        }
        guard self.drawBounds.size != .zero else { return }
        guard let image = self.pathImage(color: self.color, extend: self.extend),
              let blurImage = self.blurImage(image, size: self.fuzzy) else { return }
        switch self.shadowType! {
        case .inner:
            displayView.image = self.captureInner(with: blurImage)
        case .outer:
            displayView.image = self.captureOuter(with: blurImage)
        case .meanwhile:
            displayView.image = blurImage
        }
        displayView.alpha = self.opacity
    }
}

//MARK: - private method
extension KJShadowView {
    
    /// Generate a road map
    /// - Parameters:
    ///   - color: Path color
    ///   - extend: Path width
    /// - Returns: Path image
    private func pathImage(color: UIColor, extend: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContext(self.drawBounds.size)
        outsidePath?.lineWidth = extend * 2
        outsidePath?.lineCapStyle = .round
        if let round = self.round, round {
            outsidePath?.lineJoinStyle = .round
        }
        color.set()
        outsidePath?.stroke()
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// Clip inside the path, keep the area outside the path
    /// - Parameter image: Cropped picture
    /// - Returns: Crop image
    private func captureOuter(with image: UIImage) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.drawBounds.size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()
        if let context = context {
            context.setBlendMode(.clear) // Cropped part is transparent
            image.draw(in: self.drawBounds)
            context.addPath(outsidePath!.cgPath)
            context.drawPath(using: .eoFill)
        }
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// Crop out the area outside the path
    /// - Parameter image: Cropped picture
    /// - Returns: Crop image
    private func captureInner(with image: UIImage) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.drawBounds.size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()
        if let context = context {
            context.setBlendMode(.clear)
            image.draw(in: self.drawBounds)
            let path = UIBezierPath(rect: self.drawBounds)
            path.usesEvenOddFillRule = true
            path.append(outsidePath!)
            context.addPath(path.cgPath)
            context.drawPath(using: .eoFill)
        }
        let newimage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newimage
    }
    
    /// box blur image
    /// - Parameters:
    ///   - image: Source image
    ///   - size: Degree of blur, 0 - 1
    /// - Returns: Blur image
    private func blurImage(_ image: UIImage, size: CGFloat) -> UIImage? {
        guard 0 <= size && size < 1 else { return image }
        let size = max(min(size, 1), 0)
        var boxSize = Int(size * 100)
        boxSize = boxSize - (boxSize % 2) + 1
        guard let CGImage = image.cgImage else { return image }
        let inProvider = CGImage.dataProvider
        
        let height = vImagePixelCount(CGImage.height)
        let width  = vImagePixelCount(CGImage.width)
        let rowBytes = CGImage.bytesPerRow
        
        var inBitmapData = inProvider?.data
        let inData = UnsafeMutableRawPointer(mutating: CFDataGetBytePtr(inBitmapData))
        var inBuffer = vImage_Buffer(data: inData, height: height, width: width, rowBytes: rowBytes)
        
        let outData = malloc((CGImage.bytesPerRow) * (CGImage.height))
        var outBuffer = vImage_Buffer(data: outData, height: height, width: width, rowBytes: rowBytes)
        
        let rgbaData = malloc((CGImage.bytesPerRow) * (CGImage.height))
        var rgbaBuffer = vImage_Buffer(data: rgbaData, height: height, width: width, rowBytes: rowBytes)
        
        // box滤镜（模糊滤镜）
        vImageBoxConvolve_ARGB8888(&inBuffer,
                                   &outBuffer,
                                   nil,
                                   vImagePixelCount(0),
                                   vImagePixelCount(0),
                                   UInt32(boxSize),
                                   UInt32(boxSize),
                                   nil,
                                   vImage_Flags(kvImageEdgeExtend))
        
        /// 交换像素通道从BGRA到RGBA
        let permuteMap: [UInt8] = [2, 1, 0, 3]
        vImagePermuteChannels_ARGB8888(&outBuffer,
                                       &rgbaBuffer,
                                       permuteMap,
                                       vImage_Flags(kvImageNoFlags))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let ctx = CGContext(data: rgbaBuffer.data,
                            width: Int(rgbaBuffer.width),
                            height: Int(rgbaBuffer.height),
                            bitsPerComponent: 8,
                            bytesPerRow: rgbaBuffer.rowBytes,
                            space: colorSpace,
                            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        var imageRef = ctx.makeImage()
        let bluredImage = UIImage(cgImage: imageRef!)
        inBitmapData = nil
        imageRef = nil
        free(outData)
        free(rgbaData)
        ctx.flush()
        ctx.synchronize()
        return bluredImage
    }
}
