//
//  BaseViewController.swift
//  KJCategories_Example
//
//  Created by 77。 on 2021/11/8.
//  Copyright © 2021 CocoaPods. All rights reserved.
//  https://github.com/YangKJ/KJCategories

import UIKit
import KJCategories

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(hexString: "#F5F5F5")
    }
}

extension UIColor {
    static let background = UIColor(named: "background")
    static let defaultTint = UIColor(named: "defaultTint")
    static let cell_background = UIColor(named: "cell_background")
}
