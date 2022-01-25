//
//  GradientSliderViewController.swift
//  KJCategories_Example
//
//  Created by yangkejun on 2021/11/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//  https://github.com/YangKJ/KJCategories

import UIKit
import SnapKit
import KJCategories

class GradientSliderViewController: BaseViewController {

    private lazy var slider: KJGradientSlider = {
        let slider = KJGradientSlider.init()
        slider.value = 0.5
        slider.colors = [
            KJCategories.UIColor.init(hexString: "0xF44336"),
            KJCategories.UIColor.init(hexString: "0xFFFFFF"),
        ]
        slider.locations = [0, 0.8]
        slider.moving(withTimeSpan: 1.0) { value in
            print("moving:\(value)")
        }
        return slider
    }()
    
    private lazy var rainbowSlider: KJGradientSlider = {
        let slider = KJGradientSlider.init()
        slider.value = 0.5
        slider.colors = [
            UIColor.init(hexString: "0xFF0000"),
            UIColor.init(hexString: "0xFF7F00"),
            UIColor.init(hexString: "0xFFFF00"),
            UIColor.init(hexString: "0x00FF00"),
            UIColor.init(hexString: "0x00FFFF"),
            UIColor.init(hexString: "0x0000FF"),
            UIColor.init(hexString: "0x8B00FF"),
        ]
        slider.locations = [0, 0.16, 0.32, 0.48, 0.64, 0.8, 1]
        slider.moveEnd { value in
            print("moved:\(value)")
        }
        slider.kj_openTapChangeValue(true) { value in
            print("tap value:\(value)")
        }
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        self.view.addSubview(self.slider)
        self.view.addSubview(self.rainbowSlider)
        self.slider.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalTo(self.view).inset(30)
            make.height.equalTo(30)
        }
        self.rainbowSlider.snp.makeConstraints { make in
            make.top.equalTo(self.slider.snp.bottom).offset(30)
            make.left.right.equalTo(self.view).inset(30)
            make.height.equalTo(30)
        }
    }
}
