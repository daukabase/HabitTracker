//
//  HomeViewController.swift
//  HabitTracker
//
//  Created by Daulet on 4/5/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import SegementSlide

final class HomeViewController: SegementSlideViewController {
    
    lazy var habitsViewController: HabitsViewController = {
        guard let controller = UIStoryboard.instantiate(ofType: HabitsViewController.self) else {
            fatalError()
        }
        controller.state = .habit(items: self.habits)
        return controller
    }()
    
    lazy var challengesViewController: HabitsViewController = {
        guard let controller = UIStoryboard.instantiate(ofType: HabitsViewController.self) else {
            fatalError()
        }
        controller.state = .challenge(items: self.challenges)
        return controller
    }()
    
    var habits: [Habit] = [
        Habit(title: "Wake up early",
              notes: "Workout",
              durationDays: 10,
              startDate: Date(),
              schedule: [.monday, .wednesday, .friday],
              colorHex: "#FF3367",
              isCurrentCompleted: false,
              image: Asset.dungbell.image),
        Habit(title: "Evening meditation",
              notes: "Relax",
              durationDays: 10,
              startDate: Date(),
              schedule: [.monday, .wednesday, .friday],
              colorHex: "#50CBF5",
              isCurrentCompleted: true,
              image: Asset.dungbell.image),
        Habit(title: "Abs burning workout",
              notes: "Abs",
              durationDays: 10,
              startDate: Date(),
              schedule: [.monday, .wednesday, .friday],
              colorHex: "#916AC8",
              isCurrentCompleted: false,
              image: Asset.running.image)
    ]
    
    var challenges: [Challenge] = [
        Challenge(title: "Wake up early",
              notes: "Workout",
              durationDays: 10,
              startDate: Date(),
              schedule: [.monday, .wednesday, .friday],
              colorHex: "#FF3367",
              isCurrentCompleted: false,
              image: Asset.dungbell.image),
        Challenge(title: "Evening meditation",
              notes: "Relax",
              durationDays: 10,
              startDate: Date(),
              schedule: [.monday, .wednesday, .friday],
              colorHex: "#50CBF5",
              isCurrentCompleted: true,
              image: Asset.dungbell.image),
        Challenge(title: "Abs burning workout",
              notes: "Abs",
              durationDays: 10,
              startDate: Date(),
              schedule: [.monday, .wednesday, .friday],
              colorHex: "#916AC8",
              isCurrentCompleted: false,
              image: Asset.running.image)
    ]
    
    override var titlesInSwitcher: [String] {
        return ["Habits", "Challenge", "Program"].map { $0.uppercased() }
    }
    
    override var switcherConfig: SegementSlideSwitcherConfig {
        return SegementSlideSwitcherConfig(type: .tab,
                                           horizontalMargin: 16,
                                           horizontalSpace: 32,
                                           normalTitleFont: FontFamily.Gilroy.medium.font(size: 16),
                                           selectedTitleFont: FontFamily.Gilroy.medium.font(size: 16),
                                           normalTitleColor: ColorName.textSecondary.color,
                                           selectedTitleColor: ColorName.textPrimary.color,
                                           indicatorWidth: 86,
                                           indicatorHeight: 4,
                                           indicatorColor: ColorName.uiBlue.color,
                                           badgeHeightForPointType: 0,
                                           badgeHeightForCountType: 0,
                                           badgeHeightForCustomType: 0,
                                           badgeFontForCountType: FontFamily.Gilroy.medium.font(size: 16))
    }

    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        if index == 0 {
            return habitsViewController
        } else if index == 1 {
            return challengesViewController
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Asset.menu.image,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(menuItemDidTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Asset.filter.image,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(filterItemDidTap))
        
        reloadData()
        scrollToSlide(at: 0, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = ColorName.uiWhite.color
        navigationController?.navigationBar.tintColor = ColorName.uiGrayPrimary.color
    }

    @objc
    private func menuItemDidTap() {
        
    }
    
    @objc
    private func filterItemDidTap() {
        
    }
    
}
