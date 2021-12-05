//
//  HomeViewController.swift
//  KJCategories
//
//  Created by Zz on 2021/11/7.
//  Copyright (c) 2021 Zz. All rights reserved.
//  https://github.com/YangKJ/KJCategories

import UIKit
import SnapKit
import KJCategories

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.setupUI()
    }
    
    func setupInit() {
        self.title = "🎷测试用例"
        self.view.backgroundColor = UIColor.init(hexString: "#f5f5f5")
        // 当前设计图纸型号，适配使用
        UIResponder.kj_adaptModelType(.iPhoneX)
    }
    
    func setupUI() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalTo(self.view).inset(0)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - lazy
    private lazy var datas: [NSDictionary] = {
        return [
            ["class": "OpencvViewController", "text": "Opencv图片处理"],
            ["class": "EmitterAnimationViewController", "text": "粒子开屏动画样式"],
            ["class": "AnimationViewController", "text": "测试基础动画展示"],
            ["class": "FloodImageVieController", "text": "泛洪图片算法展览"],
            ["class": "GradientSliderViewController", "text": "彩虹渐变色滑杆"],
            ["class": "BezierPathViewController", "text": "贝塞尔圆滑路径曲线"],
            ["class": "ButtonViewController", "text": "按钮图文布局点赞粒子"],
            ["class": "LabelViewController", "text": "文本多角度展示"],
            ["class": "TextFieldViewController", "text": "账户密码输入框搭建"],
            ["class": "TextViewController", "text": "限制输入框撤销操作"],
        ]
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 44
        table.sectionHeaderHeight = 0.00001
        table.sectionFooterHeight = 0.00001
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
}

// MARK: - UITableViewDataSource,UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = UIColor.red
        cell.textLabel?.text = (NSString.init(format: "%d. ", indexPath.row+1) as String) +
        (self.datas[indexPath.row]["class"] as! String)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.textColor = UIColor.systemPink.withAlphaComponent(0.5)
        cell.detailTextLabel?.text = (self.datas[indexPath.row]["text"] as! String)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let className = self.datas[indexPath.row]["class"] as! String
        var clazz: AnyClass? = NSClassFromString(className)
        if (clazz == nil) {// Swift类需要命名空间
            let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            clazz = NSClassFromString(nameSpace + "." + className)
        }
        guard let typeClass = clazz as? UIViewController.Type else {
            return
        }
        let vc = typeClass.init()
        vc.title = (self.datas[indexPath.row]["text"] as! String)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

