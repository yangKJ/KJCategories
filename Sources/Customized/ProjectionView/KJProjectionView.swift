//
//  KJProjectionView.swift
//  KJCategories
//
//  Created by 77。 on 2021/12/10.
//  https://github.com/YangKJ/KJCategories

import UIKit
import Accelerate

// https://juejin.cn/post/7011309826592473125

@objc public final class KJProjectionView: UIView {
    
    private var fuzzy: CGFloat = 0.1
    private var opacity: CGFloat = 0.8
    private var diffuse: CGFloat = 15
    private var angle: CGFloat = 0
    private var resultImage: UIImage? = nil
    private var tempSize: CGSize = .zero
    private var sourceView: UIImageView?
    private var displayView: UIImageView = UIImageView.init()
    
    @objc public init(image: UIImage) {
        super.init(frame: .zero)
        self.sourceView = UIImageView.init(image: image)
        self.addSubview(self.displayView)
        self.addSubview(self.sourceView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.tempSize = self.frame.size
        self.displayView.frame = self.bounds
        self.sourceView?.frame = self.bounds
        self.setupResultImage()
        self.changeProjection()
    }
    
    /// Modify projection parameters
    /// - Parameters:
    ///   - fuzzy: Degree of ambiguity, `0-1`
    ///   - diffuse: Control the offset distance
    ///   - angle: The light source forms the shadow angle
    ///   - opacity: Shadow transparency, `0 - 1`
    public func changeProjection(fuzzy: CGFloat? = nil,
                                 diffuse: CGFloat? = nil,
                                 angle: CGFloat? = nil,
                                 opacity: CGFloat? = nil) {
        if let opacity = opacity {
            self.opacity = opacity
        }
        if let fuzzy = fuzzy {
            self.fuzzy = fuzzy
        }
        if let diffuse = diffuse {
            self.diffuse = diffuse
        }
        if let angle = angle {
            self.angle = angle
        }
        guard self.tempSize != .zero else { return }
        let x = self.diffuse * sin(self.angle)
        let y = self.diffuse * cos(self.angle)
        displayView.frame.origin = CGPoint(x: x, y: y)
        displayView.alpha = self.opacity
        displayView.image = blurImage(resultImage!, size: self.fuzzy)
    }
}

//MARK: - private method
extension KJProjectionView {
    
    private func setupResultImage() {
        guard let captureImage = self.capture(self.sourceView) else { return }
        self.resultImage = self.changeImageColor(UIColor.black, image: captureImage)
    }
    
    private func capture(_ view: UIView?) -> UIImage? {
        UIGraphicsBeginImageContext(view?.bounds.size ?? CGSize.zero)
        let ctx = UIGraphicsGetCurrentContext()
        if let ctx = ctx {
            view?.layer.render(in: ctx)
        }
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    private func changeImageColor(_ color: UIColor, image: UIImage) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: image.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(.normal)
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        if let CGImage = image.cgImage {
            context?.clip(to: rect, mask: CGImage)
        }
        color.setFill()
        context?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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
        
        ///`premultipliedLast`Keep transparent area
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let ctx = CGContext(data: outBuffer.data,
                            width: Int(outBuffer.width),
                            height: Int(outBuffer.height),
                            bitsPerComponent: 8,
                            bytesPerRow: outBuffer.rowBytes,
                            space: colorSpace,
                            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        var imageRef = ctx.makeImage()
        let bluredImage = UIImage(cgImage: imageRef!)
        inBitmapData = nil
        imageRef = nil
        free(outData)
        ctx.flush()
        ctx.synchronize()
        return bluredImage
    }
}
