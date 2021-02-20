//
//  ChallengesViewController.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/21/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import Haptica

protocol ChallengeDelegate: class {
    func askMark()
    func markAsDone()
}

final class ChallengesViewController: UIViewController, LoaderViewDisplayable, ErrorDisplayable {
    
    lazy var challange: Challenge = {
        let ch: Challenge = .init(id: "", title: "Run at 7", notes: "", durationDays: 20, startDate: Date(), schedule: [.friday], color: HabitColor.default.color, isCurrentCompleted: false, habitIcon: .apple, goal: (0, 20))
        
        return ch
    }()
    
    private lazy var items: [Challenge] = [challange] {
        didSet {
            emptyMessageLabel.isHidden = !items.isEmpty
        }
    }
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(updateList), for: .valueChanged)
        
        return refreshControl
    }()
    
    @IBOutlet var tableView: UITableView!
    
    private lazy var emptyMessageLabel: UILabel = {
        let label = UILabel()
        
        label.font = FontFamily.Gilroy.bold.font(size: 21)
        label.numberOfLines = .zero
        label.textColor = ColorName.uiOrange.color
        label.text = L10n.Home.Habit.Message.noToday
        label.textAlignment = .center
        label.textColor = ColorName.textSecondary.color
        
        return label
    }()
    
    private lazy var addHabitButton: RoundedShadowButton = {
        let model = RoundedShadowButtonModel(shadowModel: .blueButton,
                                             radius: 32,
                                             backgroundColor: ColorName.uiBlue.color)
        let button = RoundedShadowButton(model: model, frame: .zero)
        button.accessibilityIdentifier = "Add habit button"
        button.setImage(Asset.add.image, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        
        items = { items }()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barTintColor = ColorName.uiWhite.color
        navigationController?.navigationBar.tintColor = ColorName.uiGrayPrimary.color
    }
    
    // MARK: - Actions
    @objc
    private func updateList() {
        loadData(isInitial: false)
    }
    
    // MARK: - Private Methods
    private func commonInit() {
        view.addSubview(addHabitButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 0
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(refreshControl)
        tableView.delaysContentTouches = false
        
        view.backgroundColor = .white
        
        [emptyMessageLabel, addHabitButton].forEach(view.addSubview)
        
        emptyMessageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY).offset(-86)
            make.width.equalTo(UIScreen.main.bounds.width * 2 / 3)
        }
        
        addHabitButton.addTarget(self, action: #selector(addHabitDidTap), for: .touchUpInside)
        
        addHabitButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-24)
            make.size.equalTo(64)
        }
    }
    
    // MARK: - Action
    @objc
    private func addHabitDidTap() {
        Haptic.impact(.medium).generate()
        let controller = HabitDetailsViewController(context: .createNew, delegate: nil)
        controller.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    // MARK: - Network Interaction
    private func loadData(isInitial: Bool) {
        if isInitial {
            startLoading()
        }
        
        tableView.reloadData()
        endLoading()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ChallengeCell.identifier, for: indexPath) as! ChallengeCell
        cell.delegate = self
        cell.configure(model: viewModel)
        
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
