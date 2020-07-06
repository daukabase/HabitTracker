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

extension HabitsViewController: ChallengeDelegate {
    
    func askMark() {
        navigationController?.pushViewController(AskMarkViewController(), animated: true)
    }
    
    func markAsDone() {
        navigationController?.pushViewController(MarkAsDoneViewController(), animated: true)
    }
    
}

final class HabitsViewController: UIViewController {
    
    enum State {
        case habit(items: [Habit])
        case challenge(items: [Challenge])
    }
    
    var state: State = .habit(items: [])
    
    lazy var addHabitButton: UIButton = {
        let btn = UIButton(frame: .zero)
        
        btn.apply(style: .blue)
        switch state {
        case .challenge:
            btn.title = "Add challenge  +"
        case .habit:
            btn.title = "Add habit  +"
        }
        
        
        return btn
    }()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(addHabitButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 8
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        
        addHabitButton.addTarget(self, action: #selector(addHabitDidTap), for: .touchUpInside)
        
        let controller = HabitViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addHabitButton
            .pin
            .left(16)
            .right(16)
            .bottom(view.safeAreaInsets.bottom + 16)
            .height(50)
        
        addHabitButton.roundCorners(.allCorners, radius: addHabitButton.frame.height / 2)
    }
    
    @objc
    func addHabitDidTap() {
        let controller = HabitDetailsViewController()
        controller.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}

extension HabitsViewController: SegementSlideContentScrollViewDelegate {
    
}

extension HabitsViewController: UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = HabitViewController()
        
        if case let HabitsViewController.State.habit(items) = state {
            controller.setup(habit: items[indexPath.row])
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension HabitsViewController.State {
    
    var cellType: UITableViewCell.Type {
        switch self {
        case .habit:
            return DoneHabitCell.self
        case .challenge:
            return ChallengeCell.self
        }
    }
    
}
