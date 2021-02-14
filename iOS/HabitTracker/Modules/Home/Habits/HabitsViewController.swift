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
import Haptica

protocol ChallengeDelegate: class {
    func askMark()
    func markAsDone()
}

final class HabitsViewController: UIViewController, LoaderViewDisplayable, ErrorDisplayable {
    
    enum Row {
        case displayData
        case actionable
    }
    
    // MARK: - Properties
    private var rows: [ConfigurableCellViewModel] = [] {
        didSet {
            updateUI()
        }
    }
    
    private let interactor: HabitsInteractor = HabitsInteractor()
    
    private var isCheckpointsSegmentSelected: Bool {
        return filterView.selectedSegmentIndex == 1
    }
    
    // MARK: - Views
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(updateList), for: .valueChanged)
        
        return refreshControl
    }()
    
    private lazy var filterView: FilterView = {
        let view = FilterView()
        
        view.setup(segments: [
            FilterSegmentViewModel(title: "All habits", isSelected: false),
            FilterSegmentViewModel(title: "Due today", isSelected: true)
        ])
        
        view.onChange = { [weak self] in
            Haptic.impact(.medium).generate()
            DispatchQueue.main.async {
                self?.loadData(isInitial: false)
            }
        }
        
        return view
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
        view.addSubview(filterView)
        
        filterView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.height.equalTo(28)
        }
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
        tableView.contentInset.top = 0
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(refreshControl)
        tableView.delaysContentTouches = false
        
        emptyMessageLabel.textColor = ColorName.textSecondary.color
    }
    
    // MARK: - Network Interactions
    private func loadData(isInitial: Bool) {
        if isInitial {
            startLoading()
        }
        
        if isCheckpointsSegmentSelected {
            loadCheckpointsForToday()
        } else {
            loadAllHabits()
        }
    }
    
    private func loadCheckpointsForToday() {
        interactor.getCheckpointsForToday { [weak self] result in
            switch result {
            case let .success(habits):
                self?.rows = habits.map { HabitCellViewModel(habit: $0) }
            case let .failure(error):
                self?.showError(describedBy: error)
            }
            self?.endLoading()
            self?.refreshControl.endRefreshing()
        }
    }
    
    private func loadAllHabits() {
        interactor.getTotalHabits { [weak self] result in
            switch result {
            case let .success(habits):
                self?.rows = habits.map { HabitDisplayCellViewModel(habit: $0) }
            case let .failure(error):
                self?.showError(describedBy: error)
            }
            self?.endLoading()
            self?.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Private UI Interactions
    private func setupMessage(to block: @escaping Closure<String>) {
        block(L10n.Home.Habit.Message.noHabits)
        
        if isCheckpointsSegmentSelected {
            block(L10n.Home.Habit.Message.noToday)
        } else {
            block(L10n.Home.Habit.Message.noHabits)
        }
    }
    
    private func updateUI() {
        emptyMessageLabel.isHidden = !rows.isEmpty
            
        setupMessage { [weak self] text in
            self?.emptyMessageLabel.text = text
        }
        
        UIView.transition(with: tableView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.tableView.reloadData()
        }, completion: nil)
    }
    
}

extension HabitsViewController: SegementSlideContentScrollViewDelegate {
    // MARK: - SegementSlideContentScrollViewDelegate
}

extension HabitsViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(viewModel.cellType.type, for: indexPath)
        
        if let cell = cell as? ConfigurableCell {
            cell.configure(using: viewModel)
        }
        
        return cell
    }
    
}

extension HabitsViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = rows[indexPath.row] as? HabitDisplayCellViewModel else {
            return
        }
        
        Haptic.impact(.light).generate()
        let controller = HabitViewController()
        
        navigationController?.pushViewController(controller, animated: true)
        
        
        if Target.current == .fastlaneUiTest {
            controller.setup(habit: FastlaneData.TestData.Habits.run)
        } else {
            controller.setup(habit: viewModel.habit)
        }
        
    }
    
}
