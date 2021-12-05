//
//  OpencvViewController.swift
//  KJCategories_Example
//
//  Created by 77。 on 2021/11/8.
//  Copyright © 2021 CocoaPods. All rights reserved.
//  https://github.com/YangKJ/KJCategories

import UIKit

class OpencvViewController: BaseViewController {

    var viewModel = OpencvViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        self.view.addSubview(self.tableView)
        self.tableView.frame = self.view.bounds
    }
    
    // MARK: - lazy
    private lazy var tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 44
        table.sectionHeaderHeight = 0.00001
        table.sectionFooterHeight = 0.00001
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.contentInsetAdjustmentBehavior = .always
        table.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        return table
    }()

}

// MARK: - UITableViewDataSource,UITableViewDelegate
extension OpencvViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: NSStringFromClass(UITableViewCell.self))
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = UIColor.blue
        cell.textLabel?.text = (NSString.init(format: "%d. ", indexPath.row+1) as String) +
        (viewModel.datas[indexPath.row]["class"] as! String)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.textColor = UIColor.blue.withAlphaComponent(0.6)
        cell.detailTextLabel?.text = (viewModel.datas[indexPath.row]["describeName"] as! String)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let className = viewModel.datas[indexPath.row]["class"] as! String
        var clazz: AnyClass? = NSClassFromString(className)
        if (clazz == nil) {// Swift类需要命名空间
            let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            clazz = NSClassFromString(nameSpace + "." + className)
        }
        guard let typeClass = clazz as? BaseOpencvViewController.Type else {
            return
        }
        let vc = typeClass.init()
        vc.title = (viewModel.datas[indexPath.row]["describeName"] as! String)
        self.navigationController?.pushViewController(vc, animated: true)

    }

}
