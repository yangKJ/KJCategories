//
//  TextViewController.swift
//  KJCategories_Example
//
//  Created by abas on 2021/11/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import KJCategories

class TextViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.updateFrame()
    }
    
    func setupUI() {
        self.view.addSubview(self.textView)
        self.view.addSubview(self.button)
        self.textView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalTo(self.view).inset(20)
            make.height.equalTo(200)
        }
        self.button.snp.makeConstraints { make in
            make.top.equalTo(self.textView.snp.bottom).offset(30)
            make.centerX.equalTo(self.view)
            make.width.height.equalTo(100)
        }
    }
    
    func updateFrame() {
        self.button.kj_updateFrame()
        self.button.kj_dashedLineColor(UIColor.green, lineWidth: 3, spaceArray: [10, 5])
    }

    private lazy var textView: UITextView = {
        let textView = UITextView.init()
        textView.backgroundColor = UIColor.white
        textView.borderColor = UIColor.green
        textView.borderWidth = 1
        textView.limitCount = 128
        textView.placeHolder = "请输入文本内容"
        textView.placeHolderLabel.font = UIFont.systemFont(ofSize: 15)
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.openBackout = true
        textView.becomeFirstResponder()
        return textView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("撤销输入", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = UIColor.green.withAlphaComponent(0.2)
        button.kj_addAction { [weak self] _ in
            self?.textView.kj_textViewBackout()
        }
        return button
    }()
}
