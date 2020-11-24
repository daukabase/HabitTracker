//
//  HomeViewController.swift
//  HabitTracker
//
//  Created by Daulet on 4/5/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import SegementSlide

final class HomeViewController: SegementSlideDefaultViewController {
    
    private lazy var habitsViewController: HabitsViewController = {
        guard let controller = UIStoryboard.instantiate(ofType: HabitsViewController.self) else {
            fatalError()
        }
        
        return controller
    }()
    
    private lazy var challengesViewController = ChallengesViewController()
    
    private lazy var addHabitButton: RoundedShadowButton = {
        let model = RoundedShadowButtonModel(shadowModel: .blueButton,
                                             radius: 32,
                                             backgroundColor: ColorName.uiBlue.color)
        let button = RoundedShadowButton(model: model, frame: .zero)
        
        button.setImage(Asset.add.image, for: .normal)
        
        return button
    }()
    
    // MARK: - SegementSlideDefaultViewController
    override var titlesInSwitcher: [String] {
        return ["Habits", "Challenge"].map { $0.uppercased() }
    }
    
    override var switcherConfig: SegementSlideDefaultSwitcherConfig {
        return SegementSlideDefaultSwitcherConfig(type: .tab,
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
    
    override func didSelectContentViewController(at index: Int) {
        let isHabit = index == .zero
        if isHabit {
            animateAddButtonAppear()
        } else {
            animateAddButtonHide()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        setupMenuItems()
        
        defaultSelectedIndex = 0
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = ColorName.uiWhite.color
        navigationController?.navigationBar.tintColor = ColorName.uiGrayPrimary.color
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }

    private func setupMenuItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Asset.menu.image,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(menuItemDidTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Asset.filter.image,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(filterItemDidTap))
        
    }
    
    
    // MARK: - Private Actions
    @objc
    private func menuItemDidTap() {
        
    }
    
    @objc
    private func filterItemDidTap() {
        
    }
    
    @objc
    private func addHabitDidTap() {
        let controller = HabitDetailsViewController(context: .createNew)
        controller.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    // MARK: - Private Methods
    private func commonInit() {
        view.addSubview(addHabitButton)
        
        addHabitButton.addTarget(self, action: #selector(addHabitDidTap), for: .touchUpInside)
        
        addHabitButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-24)
            make.size.equalTo(64)
        }
    }
    
    private func animateAddButtonHide() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { [weak addHabitButton] in
            addHabitButton?.alpha = 0
        }, completion: nil)
    }
    
    private func animateAddButtonAppear() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { [weak addHabitButton] in
            addHabitButton?.alpha = 1
        }, completion: nil)
    }
    
}
