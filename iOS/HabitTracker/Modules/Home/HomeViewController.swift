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
        
        return controller
    }()
    
    lazy var challengesViewController: ChallengesViewController = {
        let controller = ChallengesViewController()
        
        return controller
    }()
    
    override var titlesInSwitcher: [String] {
        return ["Habits", "Challenge"].map { $0.uppercased() }
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

    override var bouncesType: BouncesType {
        return .child
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
