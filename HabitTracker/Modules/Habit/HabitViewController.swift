//
//  HabitViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/9/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class HabitViewController: UIViewController {

    var habit: Habit? {
        didSet {
            self.title = habit?.title
        }
    }
    
    private lazy var calendarViewController: CalendarViewController = {
        guard let controller = UIStoryboard.instantiate(ofType: CalendarViewController.self) else {
            fatalError()
        }
        
        return controller
    }()
    
    private lazy var statisticsViewController: StatisticsViewController = {
        let controller = StatisticsViewController()
        
        return controller
    }()
    
    private lazy var achievementsViewController: AchievementsViewController = {
        let controller = AchievementsViewController()
        
        return controller
    }()
    
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
    
    @IBOutlet private var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackButton(style: .dark)
        addChild(calendarViewController)
        addChild(statisticsViewController)
        addChild(achievementsViewController)
     
        stackView.addArrangedSubview(calendarViewController.view)
        stackView.addArrangedSubview(habitBanner)
        stackView.addArrangedSubview(achievementsViewController.view)
        stackView.addArrangedSubview(statisticsViewController.view)
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
    
}
