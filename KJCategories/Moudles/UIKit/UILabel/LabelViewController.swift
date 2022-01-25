//
//  LabelViewController.swift
//  KJCategories_Example
//
//  Created by yangkejun on 2021/11/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//  https://github.com/YangKJ/KJCategories

import UIKit
import SnapKit
import KJCategories

class LabelViewController: BaseViewController {

    private var lastLabel: UILabel? = nil
    public var names: [String] {
        return [
            "Upper Left", "Upper Middle", "Upper Right",
            "Left", "Middle", "Right",
            "Lower left", "lower middle", "lower right",
        ]
    }
    public var types: [KJLabelTextAlignmentType] {
        return [
            .leftTop,
            .topCenter,
            .rightTop,
            .left,
            .center,
            .right,
            .leftBottom,
            .bottomCenter,
            .rightBottom,
        ]
    }
    
    private lazy var copyLabel: UILabel = {
        let label = UILabel.init()
        label.text = "Turn on long press to copy."
        label.textColor = UIColor.orange
        label.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
        label.font = UIFont.systemFont(ofSize: 16)
        label.copyable = true
        return label
    }()
    
    private lazy var tapLabel: UILabel = {
        let label = UILabel.init()
        label.text = "This is to test the text content of the click event, `click me`, anything can be used to do the click effect, such as text, numbers, letters, links, etc."
        label.textColor = UIColor.orange
        label.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        let array = ["click event", "`click me`", "anything"]
        label.kj_addAttributeTapAction(with: array) { _, text, _, index in
            print("content:\(text)，index:\(index)")
        }
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        self.createSudoku()
        self.view.addSubview(self.copyLabel)
        self.view.addSubview(self.tapLabel)
        self.copyLabel.snp.makeConstraints { make in
            make.top.equalTo(self.lastLabel!.snp.bottom).offset(20)
            make.left.right.equalTo(self.view).inset(20)
            make.height.equalTo(40)
        }
        self.tapLabel.snp.makeConstraints { make in
            make.top.equalTo(self.copyLabel.snp.bottom).offset(20)
            make.left.right.equalTo(self.view).inset(20)
            make.height.equalTo(60)
        }
    }
}

extension LabelViewController {
    /// 创建九宫格
    private func createSudoku() {
        let colums: Int = 3
        let space: Float = 10.0
        let leading: Float = 20.0
        let width: Float = (Float(self.view.frame.size.width) -
                            Float(leading * 2) - Float(colums - 1) * space) / Float(colums)
        var x: Float = 0
        var y: Float = 0
        for (index, name) in names.enumerated() {
            let label = UILabel.init()
            label.text = name
            label.textColor = UIColor.orange
            label.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
            label.font = UIFont.systemFont(ofSize: 16)
            label.customTextAlignment = types[index]
            label.borderWidth = 1
            label.borderColor = UIColor.orange
            x = Float(index % colums) * (width + space) + leading
            y = Float(index / colums) * (width * 0.66 + space) + leading
            self.view.addSubview(label)
            label.snp.makeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(y + 20)
                make.left.equalTo(self.view).offset(x)
                make.width.equalTo(width)
                make.height.equalTo(label.snp.width).multipliedBy(0.66)
            }
            if index == names.count - 1 {
                lastLabel = label
            }
        }
    }
}
