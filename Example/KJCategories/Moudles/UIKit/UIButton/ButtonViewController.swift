//
//  ButtonViewController.swift
//  KJCategories_Example
//
//  Created by 77。 on 2021/11/8.
//  Copyright © 2021 CocoaPods. All rights reserved.
//  https://github.com/YangKJ/KJCategories

import UIKit
import SnapKit
import KJCategories

class ButtonViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.updateFrame()
    }
    
    func setupUI() {
        self.view.addSubview(self.layoutButton)
        self.layoutButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(self.view)
            make.width.equalTo(AdaptLevel(220))
            make.height.equalTo(self.layoutButton.snp.width).multipliedBy(0.5)
        }
    }
    
    func updateFrame() {
        self.layoutButton.kj_updateFrame()
        layoutButton.bezierBorder(withRadius: 10, borderWidth: 2, borderColor: UIColor.blue)
    }
    
    // MARK: - private method
    
    // find the maximum enum value
    private static let contentLayoutStyleCount: KJButtonContentLayoutStyle.RawValue = {
        var maxValue: UInt32 = 0
        while let _ = KJButtonContentLayoutStyle(rawValue: Int(maxValue)) {
            maxValue += 1
        }
        return KJButtonContentLayoutStyle.RawValue(maxValue)
    }()
    
    // MARK: - lazy
    private lazy var layoutButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.init(named: "wode_nor"), for: .normal)
        button.setTitle("居中-图上文下", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.kj_contentLayout(.centerImageTop, padding: 10)
        button.enlargeClick = 20
        button.kj_addAction { [weak self] _ in
            let count: UInt32 = 7//UInt32(ButtonViewController.contentLayoutStyleCount)
            let style = KJButtonContentLayoutStyle(rawValue: Int(arc4random()%count))
            self!.layoutButton.kj_contentLayout(style ?? .centerImageTop, padding: 10)
        }
        return button
    }()
    
}
