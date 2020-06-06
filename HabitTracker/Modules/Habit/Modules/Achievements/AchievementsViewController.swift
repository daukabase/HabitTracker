//
//  AchievementsViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/31/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class AchievementsViewController: UIViewController {

    private var achievements: [Achievement] = [
        CommonAchievement(numberOfDays: 2, description: "Current Streak", image: Asset.order.image),
        CommonAchievement(numberOfDays: 3, description: "Longest Streak", image: Asset.trophy.image),
        CommonAchievement(numberOfDays: 5, description: "Total done", image: Asset.guard.image),
        GoalAchievement(completedDays: 6, totalDays: 8, description: "Goal", image: Asset.goal.image)
    ]
    
    @IBOutlet var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        achievements.forEach(add(achievement:))
        
        view.clipsToBounds = false
        stackView.clipsToBounds = false
    }
    
    private func add(achievement: Achievement) {
        let stackToProcess: UIStackView
        
        if let subStackView = stackView.arrangedSubviews.last as? UIStackView, subStackView.arrangedSubviews.count < 2 {
            stackToProcess = subStackView
        } else {
            stackToProcess = UIStackView(frame: .zero)
            stackToProcess.alignment = .fill
            stackToProcess.distribution = .fillEqually
            stackToProcess.axis = .horizontal
            stackToProcess.spacing = 17
            stackToProcess.backgroundColor = .clear
            
            stackView.addArrangedSubview(stackToProcess)
        }
        
        let view = AchievementView(frame: .zero)
        view.configure(model: achievement)
        
        stackToProcess.addArrangedSubview(view)
    }
    

}
