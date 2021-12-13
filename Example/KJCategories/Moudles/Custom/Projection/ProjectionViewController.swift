//
//  ProjectionViewController.swift
//  KJCategories_Example
//
//  Created by abas on 2021/12/10.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import KJCategories

class ProjectionViewController: BaseViewController {

    lazy var projectionView: KJProjectionView = {
        let projectionView = KJProjectionView.init(image: UIImage.init(named: "zuqiu2")!)
        view.addSubview(projectionView)
        return projectionView
    }()
    
    lazy var fuzzyLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.blue
        label.text = "Fuzzy"
        label.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(label)
        return label
    }()
    
    lazy var angleLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.blue
        label.text = "Angle"
        label.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(label)
        return label
    }()
    
    lazy var diffuseLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.blue
        label.text = "Diffuse"
        label.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(label)
        return label
    }()
    
    lazy var fuzzySlider: UISlider = {
        let slider = UISlider.init()
        slider.minimumValue = 0
        slider.maximumValue = 0.99
        slider.value = 0.2
        //slider.constraints = true
        slider.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(0.5)
        slider.addTarget(self, action: #selector(fuzzyAction(_:)), for: .valueChanged)
        view.addSubview(slider)
        return slider
    }()
    
    lazy var angleSlider: UISlider = {
        let slider = UISlider.init()
        slider.minimumValue = 0
        slider.maximumValue = 0.9
        slider.value = 0.8
        slider.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(0.5)
        slider.addTarget(self, action: #selector(angleAction(_:)), for: .valueChanged)
        view.addSubview(slider)
        return slider
    }()
    
    lazy var diffuseSlider: UISlider = {
        let slider = UISlider.init()
        slider.minimumValue = 0
        slider.maximumValue = 60
        slider.value = 40
        slider.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(0.5)
        slider.addTarget(self, action: #selector(diffuseAction(_:)), for: .valueChanged)
        view.addSubview(slider)
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupProjection()
    }
    
    func setupUI() {
        self.projectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(self.projectionView.snp.width).multipliedBy(1)
        }
        self.fuzzyLabel.snp.makeConstraints { make in
            make.top.equalTo(self.projectionView.snp.bottom).offset(100)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(30)
        }
        self.angleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.fuzzyLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(30)
        }
        self.diffuseLabel.snp.makeConstraints { make in
            make.top.equalTo(self.angleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(30)
        }
        self.fuzzySlider.snp.makeConstraints { make in
            make.centerY.equalTo(self.fuzzyLabel)
            make.left.equalTo(self.fuzzyLabel.snp.right).offset(10)
            make.right.equalToSuperview().inset(30)
        }
        self.angleSlider.snp.makeConstraints { make in
            make.centerY.equalTo(self.angleLabel)
            make.left.equalTo(self.angleLabel.snp.right).offset(10)
            make.right.equalToSuperview().inset(30)
        }
        self.diffuseSlider.snp.makeConstraints { make in
            make.centerY.equalTo(self.diffuseLabel)
            make.left.equalTo(self.diffuseLabel.snp.right).offset(10)
            make.right.equalToSuperview().inset(30)
        }
    }
    
    func setupProjection() {
        projectionView.changeProjection(fuzzy: CGFloat(self.fuzzySlider.value),
                                        diffuse: CGFloat(self.diffuseSlider.value),
                                        angle: CGFloat(self.angleSlider.value * 7),
                                        opacity: 0.8)
    }
}

//MARK: - actions
extension ProjectionViewController {
    
    @objc func fuzzyAction(_ slider: UISlider) {
        self.projectionView.changeProjection(fuzzy: CGFloat(slider.value))
    }
    
    @objc func angleAction(_ slider: UISlider) {
        self.projectionView.changeProjection(angle: CGFloat(slider.value * 7))
    }
    
    @objc func diffuseAction(_ slider: UISlider) {
        self.projectionView.changeProjection(diffuse: CGFloat(slider.value))
    }
}
