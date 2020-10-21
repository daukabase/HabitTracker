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
    var habits: [Habit] = []
    
    // MARK: - Views
    private lazy var addButton: RoundedShadowButton = {
        let model = RoundedShadowButtonModel(shadowModel: .blueButton,
                                             radius: 32,
                                             backgroundColor: ColorName.uiBlue.color)
        let button = RoundedShadowButton(model: model, frame: .zero)
        
        button.setImage(Asset.add.image, for: .normal)
        
        return button
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(updateList), for: .valueChanged)
        
        return refreshControl
    }()
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - UIViewController
    override func loadView() {
        super.loadView()
        
        view.addSubview(addButton)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateList),
                                               name: .updateHabits,
                                               object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 8
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(refreshControl)
        
        addButton.addTarget(self, action: #selector(addHabitDidTap), for: .touchUpInside)
        
        addButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-24)
            make.size.equalTo(64)
        }
        loadData()
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
    
    @objc
    private func updateList() {
        loadData()
    }
    
    // MARK: - Private Methods
    private func loadData() {
        startLoading()
        
        HabitStorage.getCheckpointsForToday { [weak self] result in
            guard let checkpoints = result.value else {
                self?.endLoading()
                return
            }
            let group = DispatchGroup()
            var habits = [Habit]()
            
            checkpoints.forEach { checkpoint in
                group.enter()
                
                HabitStorage.getHabit(for: checkpoint.habitId) { result in
                    guard let self = self else {
                        group.leave()
                        return
                    }
                    self.getHabit(for: checkpoint.habitId, isDone: checkpoint.isDone, completion: { result in
                        defer {
                            group.leave()
                        }
                        guard let habit = result.value else {
                            return
                        }
                        habit.checkpoint = checkpoint
                        habits.append(habit)
                    })
                }
            }
            
            group.notify(queue: .main) {
                self?.endLoading()
                self?.refreshControl.endRefreshing()
                self?.habits = habits
                self?.tableView.reloadData()
            }
        }
    }

    func getHabit(for habitId: String, isDone: Bool, completion: @escaping Closure<RResult<Habit>>) {
        HabitStorage.getHabit(for: habitId) { result in
            guard
                let habit = result.value,
                case let Frequency.weekly(days) = habit.frequence,
                let startDate = habit.startDate.date(with: .storingFormat)
            else {
                completion(.failure(HTError.serialization))
                return
            }
            let _habit = Habit(id: habit.id,
                               title: habit.title,
                               notes: habit.notes,
                               durationDays: habit.durationDays,
                               startDate: startDate,
                               schedule: days,
                               colorHex: habit.colorHex,
                               isCurrentCompleted: isDone,
                               habitIcon: habit.icon,
                               goal: (0, 0))
            _habit.updateGoal {
                completion(.success(_habit))
            }
        }
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

extension HabitsViewController: ChallengeDelegate {
    
    // MARK: - ChallengeDelegate
    func askMark() {
        navigationController?.pushViewController(AskMarkViewController(), animated: true)
    }
    
    func markAsDone() {
        navigationController?.pushViewController(MarkAsDoneViewController(), animated: true)
    }
    
}
