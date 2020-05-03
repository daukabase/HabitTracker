//
//  HomeViewController.swift
//  HabitTracker
//
//  Created by Daulet on 4/5/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import SegementSlide

final class HomeViewController: SegementSlideViewController {

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
        return UIStoryboard.instantiate(ofType: HabitsViewController.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isHidden = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Asset.menu.image,
                                                                                 style: .plain,
                                                                                 target: self,
                                                                                 action: #selector(menuItemDidTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Asset.filter.image,
                                                            style: .done,
                                                            target: self,
                                                                                  action: #selector(filterItemDidTap))
        navigationController?.navigationBar.tintColor = ColorName.uiGrayPrimary.color
        
        reloadData()
        scrollToSlide(at: 0, animated: false)
    }

    @objc
    private func menuItemDidTap() {
        
    }
    
    @objc
    private func filterItemDidTap() {
        
    }
    
}
