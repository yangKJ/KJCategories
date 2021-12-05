//
//  TextFieldViewController.swift
//  KJCategories_Example
//
//  Created by abas on 2021/11/22.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import KJCategories

class TextFieldViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        self.view.addSubview(self.accountTextField)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(self.codeTextField)
        self.view.addSubview(self.emailTextField)
        self.accountTextField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalTo(self.view).inset(30)
            make.height.equalTo(40)
        }
        self.passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(self.accountTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.view).inset(30)
            make.height.equalTo(40)
        }
        self.codeTextField.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.view).inset(30)
            make.height.equalTo(40)
        }
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.codeTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.view).inset(30)
            make.height.equalTo(40)
        }
    }
    
    private lazy var accountTextField: UITextField = {
        let textField = UITextField.init()
        textField.placeholder = "请输入账号"
        textField.text = "ykj310@126.com"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        textField.kj_leftView { make in
            make.text = "账号:"
            make.padding = 5
            make.periphery = 5
            make.minWidth = 40
            make.imageName = "wode_nor"
        }
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField.init()
        textField.placeholder = "请输入密码"
        textField.text = "abc2356"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        textField.securePasswords = true
        textField.kj_leftView { make in
            make.text = "密码:"
            make.periphery = 5
        }
        textField.kj_rightViewTap({ [weak self] _ in
            textField.securePasswords = !textField.securePasswords
        }, imageName: "wode_nor", width: 20, height: 20, padding: 10)
        return textField
    }()
    
    private lazy var codeTextField: UITextField = {
        let textField = UITextField.init()
        textField.placeholder = "请输入六位验证码"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
        textField.borderWidth = 1
        textField.maxLength = 6
        textField.keyboardType = .numberPad
        let button = textField.kj_rightViewTap({ button in
            button.kj_startTime(10, countDownFormat: nil)
        }, imageName: nil, width: 70, height: 20, padding: 10)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.borderWidth = 1
        button.borderColor = UIColor.lightGray
        button.setTitle("获取验证码", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.kj_countDownTimeStop {
            print("验证码已过期")
        }
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField.init()
        textField.placeholder = "请输入邮箱"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.placeholderColor = UIColor.lightGray
        textField.bottomLineColor = UIColor.lightGray.withAlphaComponent(0.5)
        return textField
    }()
}
