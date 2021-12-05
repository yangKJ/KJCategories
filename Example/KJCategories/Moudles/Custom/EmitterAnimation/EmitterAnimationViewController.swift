//
//  EmitterAnimationViewController.swift
//  KJCategories_Example
//
//  Created by abas on 2021/11/22.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import KJCategories

class EmitterAnimationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    func setupUI() {
        self.view.layer.addSublayer(self.emitter)
        self.view.addSubview(self.resetButton)
        self.emitter.frame = self.view.bounds
        self.resetButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(100)
            make.centerX.equalTo(self.view)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    private lazy var emitter: KJEmitterAnimation = {
        let provider = KJEmitterAnimationProvider.init()
        provider.dropSpeed = 1.0
        provider.pixelBeginPoint = CGPoint(x: self.view.centerX, y: 100)
        let animation = KJEmitterAnimation.create(with: provider, emitterImage: UIImage.init(named: "pikaqiu")!) {
            print("开屏动画已结束")
        }
        return animation
    }()
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("重 置", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        button.backgroundColor = UIColor.green.withAlphaComponent(0.2)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.kj_addAction { [weak self] _ in
            self?.emitter.restart()
        }
        return button
    }()
}
