//
//  HabitViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/9/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class HabitViewController: UIViewController, LoaderViewDisplayable, ErrorDisplayable {

    // MARK: - Properties
    private var habit: Habit?
    
    // MARK: - Controllers
    private lazy var calendarViewController: CalendarViewController = {
        guard let controller = UIStoryboard.instantiate(ofType: CalendarViewController.self) else {
            fatalError()
        }
        
        return controller
    }()
    
    private lazy var achievementsViewController = AchievementsViewController()
    
    // MARK: - Views
    private lazy var habitBanner: HabitBanner = {
        let view = HabitBanner()
        
        view.setup(model: HabitBannerViewModel(days: 3))
        
        return view
    }()
    
    private lazy var habitTitleView = HabitTitleView(frame: .zero)
    
    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var scrollView: UIScrollView!
    
    // MARK: - Superview
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = habitTitleView
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Asset.more.image,
            style: .done,
            target: self,
            action: #selector(didTapRightBarButton(sender:))
        )

        scrollView.contentInset.bottom = view.safeAreaInsets.bottom
        setBackButton(style: .dark)
        addChild(calendarViewController)
        addChild(achievementsViewController)
     
        stackView.addArrangedSubview(calendarViewController.view)
        stackView.addArrangedSubview(achievementsViewController.view)
        stackView.clipsToBounds = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigation(style: .light)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Internal Methods
    func setup(habit: Habit) {
        self.habit = habit
        achievementsViewController.setup(habitId: habit.id)
        habitTitleView.setup(title: habit.title,
                             image: habit.image,
                             color: habit.color)
        setupCheckpoints(for: habit)
    }
    
    // MARK: - Private Actions
    @objc
    private func didTapRightBarButton(sender: UIBarButtonItem) {
        let modalController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(
            title: L10n.Habit.Action.Edit.message,
            style: .default,
            handler: { [weak self] _ in
                self?.handleEditAction()
        })
        let cancelAction = UIAlertAction(title: L10n.Common.cancel, style: .cancel, handler: nil)
        
        [editAction, cancelAction].forEach(modalController.addAction)
        
        present(modalController, animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    private func setupCheckpoints(for habit: Habit) {
        let model = CalendarViewModel(checkpoints: FastlaneData.TestData.Checkpoints.checkpoints, color: habit.color)
        
        calendarViewController.setup(model: model)
        return 
        guard Target.current != .fastlaneUiTest else {
            let model = CalendarViewModel(checkpoints: FastlaneData.TestData.Checkpoints.checkpoints, color: habit.color)
            
            calendarViewController.setup(model: model)
            return
        }
        
        HabitStorage.getCheckpoints(for: habit.id) { result in
            guard let checkpoints = result.value else {
                return
            }
            let model = CalendarViewModel(checkpoints: checkpoints, color: habit.color)
            
            self.calendarViewController.setup(model: model)
        }
    }
    
    private func handleEditAction() {
        guard let habit = habit else {
            return
        }
        
        let controller = HabitDetailsViewController(context: .edit(habit), delegate: self)
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension HabitViewController: HabitDetailsDelegate {
    
    func didEndEditHabit() {
        guard let habit = habit else {
            return
        }
        startLoading()
        
        HabitRepository.shared.getHabitViewModel(by: habit.id,
                                                 checkpoint: nil) { [weak self] result in
            switch result {
            case let .success(habit):
                self?.setup(habit: habit)
            case let .failure(error):
                self?.showError(describedBy: error)
            }
            self?.endLoading()
        }
    }
    
}
