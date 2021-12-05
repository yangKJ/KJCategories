//
//  AnimationViewController.swift
//  KJCategories_Example
//
//  Created by abas on 2021/11/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//  https://github.com/YangKJ/KJCategories

import UIKit
import KJCategories

class AnimationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        let colums: Int = 3
        let space: CGFloat = 20.0
        let leading: CGFloat = 20.0
        let width: CGFloat = (CGFloat(self.view.frame.size.width) -
                              CGFloat(leading * 2) - CGFloat(colums - 1) * space) / CGFloat(colums)
        for i in stride(from: 0, to: 10, by: 2) {
            let view = UIView.init(frame: CGRect(x: CGFloat((i/2) % colums) * (width + space) + leading,
                                                 y: CGFloat((i/2) / colums) * (width + space) + leading + 100,
                                                 width: width, height: width))
            view.backgroundColor = UIColor.green.withAlphaComponent(0.2)
            view.cornerRadius = 5
            view.borderWidth = 1
            view.borderColor = UIColor.green
            self.view.addSubview(view)
            
            let shadow = UIView.init()
            shadow.frame = view.frame
            shadow.backgroundColor = UIColor.green.withAlphaComponent(0.2)
            shadow.shadowColor(UIColor.green, offset: CGSize(width: 10, height: 10), radius: 10)
            self.view.addSubview(shadow)
        }
        self.view.addSubview(self.movingView)
        self.view.addSubview(self.rotateView)
    }
    
    private lazy var movingView: UIView = {
        let view = UIView.init(frame: CGRect(x: 20, y: 0, width: 100, height: 100))
        view.centerY = self.view.centerY + 20
        view.backgroundColor = UIColor.green.withAlphaComponent(0.4)
        view.bezierBorder(withRadius: 10, borderWidth: 3, borderColor: UIColor.black.withAlphaComponent(0.5))
        view.viewImage = UIImage.init(named: "pikaqiu")!
        view.kj_animationMove(CGPoint(x: self.view.width - 20 - 50, y: view.centerY)) { [weak self] make in
            make.kRepeatCount(0).kDuration(2)
            make.kAutoreverses(true)
        }
        return view
    }()
    
    private lazy var rotateView: UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.top = self.movingView.bottom + 50
        view.centerX = self.view.centerX
        view.backgroundColor = UIColor.green.withAlphaComponent(0.4)
        view.cornerRadius = 10
        view.borderWidth = 1.5
        view.borderColor = UIColor.black.withAlphaComponent(0.5)
        view.kj_animationRotateClockwise(true) { [weak self] make in
            make.kRepeatCount(0).kDuration(0.3).kAutoreverses(true);
        }
        view.kj_AddGestureRecognizer(.longPress) { view, _ in
            view.layer.removeAnimation(forKey: "rotate-layer")
        }
        return view
    }()
}
