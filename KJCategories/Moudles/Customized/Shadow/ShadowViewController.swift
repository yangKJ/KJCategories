//
//  ShadowViewController.swift
//  KJCategories_Example
//
//  Created by abas on 2021/12/10.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import KJCategories

class ShadowViewController: BaseViewController {

    lazy var shadowView: KJShadowView = {
        let shadowView = KJShadowView.init(image: UIImage.init(named: "zuqiu")!, type: .outer)
        shadowView.layer.borderColor = UIColor.blue.cgColor
        shadowView.layer.borderWidth = 2
        view.addSubview(shadowView)
        return shadowView
    }()
    
    lazy var roundButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("round", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    lazy var typeSegmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl.init(items: ["inner", "outer", "meanwhile"])
        segment.selectedSegmentIndex = 1
        let font = UIFont.systemFont(ofSize: 14)
        segment.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        segment.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        segment.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        /// Remove the vertical line in the middle
        segment.setDividerImage(UIImage.kj_image(with: UIColor.clear, size: .zero),
                                forLeftSegmentState: .normal,
                                rightSegmentState: .normal,
                                barMetrics: .default)
        view.addSubview(segment)
        return segment
    }()
    
    lazy var fuzzyLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.blue
        label.text = "Fuzzy"
        label.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(label)
        return label
    }()
    
    lazy var extendLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.blue
        label.text = "Extend"
        label.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(label)
        return label
    }()
    
    lazy var opacityLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.blue
        label.text = "Opacity"
        label.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(label)
        return label
    }()
    
    lazy var fuzzySlider: UISlider = {
        let slider = UISlider.init()
        slider.minimumValue = 0
        slider.maximumValue = 0.99
        slider.value = 0.2
        slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(0.5)
        slider.addTarget(self, action: #selector(fuzzyAction(_:)), for: .valueChanged)
        view.addSubview(slider)
        return slider
    }()
    
    lazy var extendSlider: UISlider = {
        let slider = UISlider.init()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 30
        slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(0.5)
        slider.addTarget(self, action: #selector(extendAction(_:)), for: .valueChanged)
        view.addSubview(slider)
        return slider
    }()
    
    lazy var opacitySlider: UISlider = {
        let slider = UISlider.init()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.97
        slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(0.5)
        slider.addTarget(self, action: #selector(opacityAction(_:)), for: .valueChanged)
        view.addSubview(slider)
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupShadow()
    }
    
    func setupUI() {
        self.shadowView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(60)
            make.left.right.equalToSuperview().inset(60)
            make.height.equalTo(self.shadowView.snp.width).multipliedBy(1)
        }
        self.roundButton.snp.makeConstraints { make in
            make.top.equalTo(self.shadowView.snp.bottom).offset(80)
            make.left.equalToSuperview().offset(30)
            make.right.equalTo(self.typeSegmentedControl.snp.left)
            make.height.equalTo(30)
        }
        self.typeSegmentedControl.snp.makeConstraints { make in
            make.centerY.equalTo(self.roundButton)
            make.right.equalToSuperview().inset(30)
            make.left.equalTo(self.roundButton.snp.right)
            make.width.equalTo(self.roundButton.snp.width).multipliedBy(3)
            make.height.equalTo(30)
        }
        self.fuzzyLabel.snp.makeConstraints { make in
            make.top.equalTo(self.roundButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(30)
        }
        self.extendLabel.snp.makeConstraints { make in
            make.top.equalTo(self.fuzzyLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(30)
        }
        self.opacityLabel.snp.makeConstraints { make in
            make.top.equalTo(self.extendLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(30)
        }
        self.fuzzySlider.snp.makeConstraints { make in
            make.centerY.equalTo(self.fuzzyLabel)
            make.left.equalTo(self.fuzzyLabel.snp.right).offset(10)
            make.right.equalToSuperview().inset(30)
        }
        self.extendSlider.snp.makeConstraints { make in
            make.centerY.equalTo(self.extendLabel)
            make.left.equalTo(self.extendLabel.snp.right).offset(10)
            make.right.equalToSuperview().inset(30)
        }
        self.opacitySlider.snp.makeConstraints { make in
            make.centerY.equalTo(self.opacityLabel)
            make.left.equalTo(self.opacityLabel.snp.right).offset(10)
            make.right.equalToSuperview().inset(30)
        }
    }
    
    func setupShadow() {
        shadowView.changeShadow(
            color: UIColor.blue.withAlphaComponent(0.5),
            fuzzy: CGFloat(self.fuzzySlider.value),
            extend: CGFloat(self.extendSlider.value),
            opacity: CGFloat(self.opacitySlider.value)
        )
    }
}

//MARK: - actions
extension ShadowViewController {
    
    @objc func buttonAction(_ button: UIButton) {
        self.shadowView.round = true
    }
    
    @objc func segmentAction(_ segment: UISegmentedControl) {
        self.shadowView.shadowType = ImageShadowType.init(rawValue: segment.selectedSegmentIndex)!
    }
    
    @objc func fuzzyAction(_ slider: UISlider) {
        self.shadowView.changeShadow(fuzzy: CGFloat(slider.value))
    }
    
    @objc func extendAction(_ slider: UISlider) {
        self.shadowView.changeShadow(extend: CGFloat(slider.value))
    }
    
    @objc func opacityAction(_ slider: UISlider) {
        self.shadowView.changeShadow(opacity: CGFloat(slider.value))
    }
}
