//
//  ViewController.swift
//  productamount
//
//  Created by Nurbek Ismagulov on 10/7/19.
//  Copyright © 2019 Nurbek Ismagulov. All rights reserved.
//

import UIKit

protocol SettingsViewInput: class {
    func reload()
}

enum SettingsViewModelType {
    case main
}

extension SettingsViewModelType {
    
    var title: String {
        switch self {
        case .main:
            return "Settings"
        }
    }
    
}


extension SettingsViewModel.CellType {
    
    var title: String {
        switch self {
        case .empty:
            return ""
        case .rate:
            return "Оцените нас в App Store"
        case .privacy:
            return "Политика конфиденциальности"
        case .terms:
            return "Условия эксплуатации"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .rate, .empty, .privacy, .terms:
            return nil
        }
    }
    
}

struct SettingsViewModel {
    
    enum CellType: String {
        case rate, empty, privacy, terms
    }
    
    
    private var view: SettingsViewInput?
    
    var items: [CellType]
    
    init(view: SettingsViewInput, type: SettingsViewModelType) {
        self.view = view
        
        switch type {
        case .main:
            items = [
                .rate, .privacy, .terms
            ]
        }
        self.view?.reload()
    }
    
}

extension SettingsTableViewController: SettingsViewInput {
    
    func reload() {
        tableView.reloadData()
    }
    
}

class SettingsTableViewController: UIViewController, LoaderViewDisplayable, ErrorDisplayable {
    
    private enum LocalConstants {
        static let cellIdentifier = "SettingsTableViewCell"
        static let cellHeight: CGFloat = 46.55
        static let sectionHeaderHeight: CGFloat = 31.62
    }
    
    var moduleType: SettingsViewModelType = .main
    
    lazy var viewModel: SettingsViewModel = {
        return SettingsViewModel(view: self, type: moduleType)
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: LocalConstants.cellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = LocalConstants.cellHeight
        tableView.clipsToBounds = true
        tableView.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var versionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 203/255, green: 203/255, blue: 203/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        commonInit()
        if case SettingsViewModelType.main = moduleType {
            set(version: Bundle.main.releaseVersionNumber ?? "")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation(style: .blue)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func commonInit() {
        title = moduleType.title
        
        setBackButton(style: .light)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        view.addSubview(tableView)
        view.addSubview(versionLabel)
        
        versionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        versionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 45).isActive = true
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: versionLabel.topAnchor, constant: 24).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    
    private func set(version: String) {
        versionLabel.text = "Версия приложения: \(version)"
    }
    
}


extension SettingsTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocalConstants.cellIdentifier, for: indexPath) as! SettingsTableViewCell
        
        let item = viewModel.items[indexPath.section]
        
        if case SettingsViewModel.CellType.empty = item {
            cell.enableEmpty()
        } else {
            cell.set(text: item.title, image: item.icon)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return LocalConstants.sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = viewModel.items[indexPath.section]
        
        switch item {
        case .empty:
            break
        case .rate:
            rateOnAppStore()
        case .privacy:
            showWeb(type: .privacy)
        case .terms:
            showWeb(type: .terms)
        }
    }
    
    private func showWeb(type: DisplayWebContentType) {
        let controller = DisplayWebPageViewController()
        
        controller.content = type
        
        present(controller, animated: true, completion: nil)
    }
}

private extension SettingsTableViewController {
    
    func rateOnAppStore() {
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/" + "1540571421") else {
            return
        }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
}
