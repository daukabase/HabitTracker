//
//  ChallengesViewController.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/21/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit


protocol ChallengeDelegate: class {
    func askMark()
    func markAsDone()
}

final class ChallengesViewController: UIViewController, LoaderViewDisplayable, ErrorDisplayable {
    
    private var items: [Challenge] = []
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(updateList), for: .valueChanged)
        
        return refreshControl
    }()
    
    @IBOutlet var tableView: UITableView!
    
    lazy var emptyMessageLabel: UILabel = {
        let label = UILabel()
        
        label.font = FontFamily.Gilroy.bold.font(size: 21)
        label.numberOfLines = .zero
        label.textColor = ColorName.uiOrange.color
        label.text = L10n.Home.Challenge.Message.comingSoon
        label.textAlignment = .center
        label.textColor = ColorName.textSecondary.color
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    // MARK: - Actions
    @objc
    private func updateList() {
        loadData(isInitial: false)
    }
    
    // MARK: - Private Methods
    private func commonInit() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 0
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(refreshControl)
        tableView.delaysContentTouches = false
        
        view.backgroundColor = .white
        
        [emptyMessageLabel].forEach(view.addSubview)
        
        emptyMessageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY).offset(-86)
            make.width.equalTo(UIScreen.main.bounds.width * 2 / 3)
        }
    }
    
    // MARK: - Network Interaction
    private func loadData(isInitial: Bool) {
        if isInitial {
            startLoading()
        }
        
        
    }
    
}

extension ChallengesViewController: UITableViewDelegate {
        
    // MARK: - UITableViewDelegate
    
}

extension ChallengesViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(ChallengeCell.self, for: indexPath)
        cell.delegate = self
        
        return cell
    }
    
}

extension ChallengesViewController: ChallengeDelegate {
    
    // MARK: - ChallengeDelegate
    func askMark() {
        
    }
    
    func markAsDone() {
        
    }
    
}
