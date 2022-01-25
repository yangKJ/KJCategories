//
//  HomeViewController.swift
//  KJCategories
//
//  Created by 77。 on 2021/11/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//  https://github.com/YangKJ/KJCategories

import UIKit
import SnapKit
import KJCategories

class HomeViewController: UIViewController {

    private static let identifier = "homeCellIdentifier"
    private let viewModel: HomeViewModel = HomeViewModel()
    
    private lazy var tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.sectionHeaderHeight = 0.00001
        table.sectionFooterHeight = 0.00001
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: HomeViewController.identifier)
        table.backgroundColor = .clear
        table.rowHeight = UITableView.automaticDimension
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.setupUI()
    }
    
    func setupInit() {
        self.title = "Case"
        view.backgroundColor = UIColor.background
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
}

// MARK: - UITableViewDataSource,UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = self.viewModel.datas[indexPath.row]
        let cell = UITableViewCell(style: .value1, reuseIdentifier: HomeViewController.identifier)
        cell.selectionStyle = .none
        cell.accessoryType = .none
        cell.textLabel?.textColor = UIColor.defaultTint
        cell.textLabel?.text = "\(indexPath.row + 1). " + String(describing: type(of: element.viewController()))
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.textColor = UIColor.defaultTint?.withAlphaComponent(0.5)
        cell.detailTextLabel?.text = element.rawValue
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.cell_background?.withAlphaComponent(0.6)
        } else {
            cell.backgroundColor = UIColor.background
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = self.viewModel.datas[indexPath.row]
        let vc: UIViewController = type.viewController()
        vc.title = type.rawValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
