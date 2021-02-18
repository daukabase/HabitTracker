//
//  HomeViewController.swift
//  HabitTracker
//
//  Created by Daulet on 4/5/20.
//  Copyright © 2020 Daulet. All rights reserved.
//


import Haptica

class HomeViewController: UIViewController {
    
    enum Constants {
        static let addHabitButtonAnimationDuration = 0.3
    }
    
    private lazy var habitsViewController: HabitsViewController = {
        guard let controller = UIStoryboard.instantiate(ofType: HabitsViewController.self) else {
            fatalError()
        }
        
        return controller
    }()
    
    private lazy var addHabitButton: RoundedShadowButton = {
        let model = RoundedShadowButtonModel(shadowModel: .blueButton,
                                             radius: 32,
                                             backgroundColor: ColorName.uiBlue.color)
        let button = RoundedShadowButton(model: model, frame: .zero)
        button.accessibilityIdentifier = "Add habit button"
        button.setImage(Asset.add.image, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        commonInit()
        setupMenuItems()
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
        addChild(habitsViewController)
        
        view.addSubview(habitsViewController.view)
        view.addSubview(addHabitButton)
        
        
        addHabitButton.addTarget(self, action: #selector(addHabitDidTap), for: .touchUpInside)
        
        addHabitButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-24)
            make.size.equalTo(64)
        }
        habitsViewController.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
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
