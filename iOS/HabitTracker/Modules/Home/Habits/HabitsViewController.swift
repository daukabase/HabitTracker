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

final class HabitsViewController: UIViewController, LoaderViewDisplayable {
    
    // MARK: - Properties
    private var habits: [Habit] = [] {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Views
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(updateList), for: .valueChanged)
        
        return refreshControl
    }()
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var emptyMessageLabel: UILabel!
    
    // MARK: - UIViewController
    override func loadView() {
        super.loadView()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateList),
                                               name: .updateHabits,
                                               object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        loadData(isInitial: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        tableView.contentInset.top = 8
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(refreshControl)
        tableView.delaysContentTouches = false
        
        emptyMessageLabel.textColor = ColorName.textSecondary.color
    }
    
    private func loadData(isInitial: Bool) {
        if isInitial {
            startLoading()
        }
        
        HabitStorage.getCheckpointsForToday { [weak self] result in
            guard let checkpoints = result.value else {
                self?.endLoading()
                return
            }
            
            self?.getHabits(for: checkpoints, completion: { habits in
                self?.endLoading()
                self?.refreshControl.endRefreshing()
                self?.habits = habits
            })
        }
    }
    
    private func getHabits(for checkpoints: [CheckpointModel], completion: @escaping Closure<[Habit]>) {
        let group = DispatchGroup()
        var habits = [Habit]()
        
        checkpoints.forEach { checkpoint in
            group.enter()
            HabitRepository.shared.getHabitViewModel(using: checkpoint) { result in
                defer {
                    group.leave()
                }
                guard let habit = result.value else {
                    return
                }
                habits.append(habit)
            }
        }
        
        group.notify(queue: .main) {
            completion(habits)
        }
    }
    
    // MARK: - Private UI Interactions
    private func setupMessage(to block: @escaping Closure<String>) {
        HabitStorage.getTotalHabits { result in
            guard let habits = result.value, habits.isEmpty else {
                block(L10n.Home.Habit.Message.noToday)
                return
            }
            block(L10n.Home.Habit.Message.noHabits)
        }
    }
    
    private func updateUI() {
        emptyMessageLabel.isHidden = !habits.isEmpty
            
        setupMessage { [weak self] text in
            self?.emptyMessageLabel.text = text
        }
        
        tableView.reloadData()
    }
    
}


extension HabitsViewController: SegementSlideContentScrollViewDelegate {
    // MARK: - SegementSlideContentScrollViewDelegate
}

extension HabitsViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitCell.identifier, for: indexPath) as! HabitCell
        
        let habit = habits[indexPath.row]
        cell.configure(model: habit)
        
        return cell
    }
    
}

extension HabitsViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = HabitViewController()
        controller.setup(habit: habits[indexPath.row])
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
