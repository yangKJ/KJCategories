//
//  BezierPathView.swift
//  KJCategories_Example
//
//  Created by yangkejun on 2021/12/10.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class BezierPathView: UIView {

    public lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer.init()
        layer.strokeColor = UIColor.init(hexString: "#4BC0B9").cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 1.0;
        layer.lineCap  = .round;
        layer.lineJoin = .round;
        layer.contentsScale = UIScreen.main.scale
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.layer.addSublayer(self.shapeLayer)
    }
}
