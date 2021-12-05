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
        
//        self.navigationController?.navigationBar.navgationBarBottomLine.backgroundColor = UIColor.red
//
//        if let imageView = self.findNavLineView(view: self.navigationController?.navigationBar) {
//            // 在分隔线上添加一个跟分隔线大小一模一样的View, 然后修改颜色即可
//            let navBarLineView = UIView()
//            navBarLineView.frame = imageView.bounds
//            navBarLineView.backgroundColor = UIColor.red
//            imageView.addSubview(navBarLineView)
//        }
    }
    
    // 获取导航栏的分隔线
    func findNavLineView(view: UIView?) -> UIImageView? {
        if let view = view {
            if view.isKind(of: UIImageView.self) && view.height <= 1.0 {
                return view as? UIImageView
            }
            for subView in view.subviews {
                let imageView = findNavLineView(view: subView)
                if imageView != nil {
                    return imageView
                }
            }
        }
        return nil
    }

}
