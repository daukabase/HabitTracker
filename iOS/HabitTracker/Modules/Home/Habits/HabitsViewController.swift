//
//  HabitsViewController.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import SegementSlide
import PinLayout

protocol ChallengeDelegate: class {
    func askMark()
    func markAsDone()
}

final class HabitsViewController: UIViewController {
    
    // MARK: - Nested Types
    enum State {
        case habit(items: [Habit])
        case challenge(items: [Challenge])
    }
    
    // MARK: - Properties
    var state: State = .habit(items: [])
    
    
    // MARK: - Views
    private lazy var addButton: RoundedShadowButton = {
        let model = RoundedShadowButtonModel(shadowModel: .blueButton,
                                             radius: 32,
                                             backgroundColor: ColorName.uiBlue.color)
        let button = RoundedShadowButton(model: model, frame: .zero)
        
        button.setImage(Asset.add.image, for: .normal)
        
        return button
    }()
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - UIViewController
    override func loadView() {
        super.loadView()
        
        view.addSubview(addButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 8
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        
        addButton.addTarget(self, action: #selector(addHabitDidTap), for: .touchUpInside)
        
        addButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-24)
            make.size.equalTo(64)
        }
        
        let controller = HabitViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Actions
    @objc
    private func addHabitDidTap() {
        let controller = HabitDetailsViewController()
        controller.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}


extension HabitsViewController: SegementSlideContentScrollViewDelegate {
    // MARK: - SegementSlideContentScrollViewDelegate
}

extension HabitsViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case let .habit(items):
            return items.count
        case let .challenge(items):
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(state.cellType, for: indexPath)
        
        switch state {
        case let .habit(items):
            if let cell = cell as? DoneHabitCell {
                cell.configure(model: items[indexPath.row])
                cell.onProgress = { isSelected in
                    Notifications.shared.scheduleNotification(notificationType: "Test")
                }
            }
        case let .challenge(items):
            if let cell = cell as? ChallengeCell {
                cell.configure(model: items[indexPath.row])
                cell.delegate = self
            }
        }
        
        return cell
    }
    
}

extension HabitsViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = HabitViewController()
        
        if case let HabitsViewController.State.habit(items) = state {
            controller.setup(habit: items[indexPath.row])
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension HabitsViewController: ChallengeDelegate {
    
    // MARK: - ChallengeDelegate
    func askMark() {
        navigationController?.pushViewController(AskMarkViewController(), animated: true)
    }
    
    func markAsDone() {
        navigationController?.pushViewController(MarkAsDoneViewController(), animated: true)
    }
    
}


extension HabitsViewController.State {
    
    // MARK: - State Properties
    var cellType: UITableViewCell.Type {
        switch self {
        case .habit:
            return DoneHabitCell.self
        case .challenge:
            return ChallengeCell.self
        }
    }
    
}
