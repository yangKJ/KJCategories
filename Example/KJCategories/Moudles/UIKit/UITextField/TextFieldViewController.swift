//
//  TextFieldViewController.swift
//  KJCategories_Example
//
//  Created by yangkejun on 2021/11/22.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import KJCategories

class TextFieldViewController: BaseViewController {
    
    private lazy var accountTextField: UITextField = {
        let textField = UITextField.init()
        textField.placeholder = "Please enter account."
        textField.text = "ykj310@126.com"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        textField.kj_leftView { make in
            make.text = "Account:"
            make.padding = 5
            make.periphery = 5
            make.minWidth = 40
            make.imageName = "wode_nor"
        }
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField.init()
        textField.placeholder = "Please enter the password."
        textField.text = "abc2356"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        textField.securePasswords = true
        textField.kj_leftView { make in
            make.text = "Password:"
            make.periphery = 5
        }
        textField.kj_rightViewTap({ [weak self] _ in
            textField.securePasswords = !textField.securePasswords
        }, imageName: "wode_nor", width: 20, height: 20, padding: 10)
        return textField
    }()
    
    private lazy var codeTextField: UITextField = {
        let textField = UITextField.init()
        textField.placeholder = "Please enter the six code."
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
        button.setTitle("Get code", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.kj_countDownTimeStop {
            print("The verification code has expired")
        }
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField.init()
        textField.placeholder = "Please input your email."
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.placeholderColor = UIColor.lightGray
        textField.bottomLineColor = UIColor.lightGray.withAlphaComponent(0.5)
        return textField
    }()

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
}
