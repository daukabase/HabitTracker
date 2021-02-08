//
//  HomeViewController.swift
//  HabitTracker
//
//  Created by Daulet on 4/5/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import SegementSlide
import Haptica

final class HomeViewController: SegementSlideDefaultViewController {
    
    enum Constants {
        static let addHabitButtonAnimationDuration = 0.3
    }
    
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
        let count = CGFloat(titlesInSwitcher.count)
        let spacing: CGFloat = 32
        let corners = spacing * 2
        let spacingBetweenSegments = (spacing - 1) / count
        let indicatorWidth = (UIScreen.main.bounds.width - corners - spacingBetweenSegments) / count
        
        return SegementSlideDefaultSwitcherConfig(type: .tab,
                                                  horizontalMargin: 16,
                                                  horizontalSpace: 32,
                                                  normalTitleFont: FontFamily.Gilroy.medium.font(size: 16),
                                                  selectedTitleFont: FontFamily.Gilroy.medium.font(size: 16),
                                                  normalTitleColor: ColorName.textSecondary.color,
                                                  selectedTitleColor: ColorName.textPrimary.color,
                                                  indicatorWidth: indicatorWidth,
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

    // MARK: - Private Actions
    @objc
    private func settingsItemDidTap() {
        let controller = SettingsTableViewController()
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc
    private func addHabitDidTap() {
        Haptic.impact(.medium).generate()
        let controller = HabitDetailsViewController(context: .createNew, delegate: nil)
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
    
    private func setupMenuItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Asset.settings.image,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(settingsItemDidTap))
    }
    
    private func animateAddButtonHide() {
        UIView.animate(withDuration: Constants.addHabitButtonAnimationDuration, delay: 0, options: .curveEaseInOut, animations: { [weak addHabitButton] in
            addHabitButton?.alpha = 0
        }, completion: nil)
    }
    
    private func animateAddButtonAppear() {
        UIView.animate(withDuration: Constants.addHabitButtonAnimationDuration, delay: 0, options: .curveEaseInOut, animations: { [weak addHabitButton] in
            addHabitButton?.alpha = 1
        }, completion: nil)
    }
    
}
