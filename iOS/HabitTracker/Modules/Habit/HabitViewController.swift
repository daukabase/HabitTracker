//
//  HabitViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/9/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class HabitViewController: UIViewController {

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
    private lazy var imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        
        image.image = Asset.habitInfo.image
        
        return image
    }()
    
    private lazy var habitBanner: HabitBanner = {
        let view = HabitBanner()
        
        view.setup(model: HabitBannerViewModel(days: 3))
        
        return view
    }()
    
    private lazy var habitTitleView = HabitTitleView(frame: .zero)
    
    @IBOutlet private var stackView: UIStackView!
    
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

        setBackButton(style: .dark)
        addChild(calendarViewController)
        addChild(achievementsViewController)
     
        stackView.addArrangedSubview(calendarViewController.view)
        stackView.addArrangedSubview(habitBanner)
        stackView.addArrangedSubview(achievementsViewController.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.roundCorners([.bottomLeft, .bottomRight], radius: 24)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: FontFamily.Gilroy.medium.font(size: 18)!,
            NSAttributedString.Key.foregroundColor: ColorName.textBlack.color
        ]
        
    }
    
    // MARK: - Internal Methods
    func setup(habit: Habit) {
        self.habit = habit
        achievementsViewController.setup(habitId: habit.id)
        habitTitleView.setup(title: habit.title,
                             image: habit.image,
                             color: habit.color)
        HabitStorage.getCheckpoints(for: habit.id) { (result) in
            guard let checkpoints = result.value else {
                return
            }
            let model = CalendarViewModel(checkpoints: checkpoints, color: habit.color)
            
            self.calendarViewController.setup(model: model)
        }
    }
    
    // MARK: - Private Actions
    @objc
    private func didTapRightBarButton(sender: UIBarButtonItem) {
        
    }
    
}
