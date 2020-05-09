//
//  HabitViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/9/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class HabitViewController: UIViewController {

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
    
    
    lazy var habitBanner: HabitBanner = {
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
        
        stackView.addArrangedSubview(calendarViewController.view)
        stackView.addArrangedSubview(habitBanner)
        
        stackView.addArrangedSubview(statisticsViewController.view)
        
    }

}
