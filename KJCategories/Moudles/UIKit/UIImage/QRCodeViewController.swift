//
//  QRCodeViewController.swift
//  KJCategories_Example
//
//  Created by abas on 2021/12/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import KJCategories

class QRCodeViewController: BaseViewController {

    lazy var barcodeImageView = UIImageView.init()
    lazy var QRCodeImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.borderColor = UIColor.blue.withAlphaComponent(0.5)
        imageView.borderWidth = 1.5
        imageView.cornerRadius = 5
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setDatas()
    }
    
    func setupUI() {
        self.view.addSubview(self.QRCodeImageView)
        self.view.addSubview(self.barcodeImageView)
        self.QRCodeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.height.equalTo(200)
        }
        self.barcodeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(QRCodeImageView.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
    }
    
    func setDatas() {
        let text = "Please give me a star, thanks \n GitHub: https://github.com/yangKJ/KJCategories"
        kQRCodeImageFromColor({ [weak self] image in
            self?.QRCodeImageView.image = image
        }, text, 600, UIColor.blue.withAlphaComponent(0.2))
        self.barcodeImageView.image = UIImage.kj_barcodeImage(withContent: "barcode image", codeImageSize: 200)
    }
}
