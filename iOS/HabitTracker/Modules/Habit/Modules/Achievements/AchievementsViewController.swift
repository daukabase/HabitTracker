//
//  AchievementsViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/31/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class AchievementsViewController: UIViewController, ErrorDisplayable {
    
    @IBOutlet var stackView: UIStackView!
    
    var execteOfLoad: EmptyClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.clipsToBounds = false
        stackView.clipsToBounds = false
        execteOfLoad?()
    }
    
    func setup(habitId: String) {
        guard isViewLoaded else {
            execteOfLoad = { [weak self] in
                self?.setup(habitId: habitId)
            }
            
            return
        }
        
        guard Target.current != .uiTest else {
            setup(FastlaneData.TestData.Achievements.testData)   
            return
        }
        
        AchievementsRepository.shared.getAchievements(for: habitId) { (result) in
            switch result {
            case let .success(achevements):
                self.setup(achevements)
            case let .failure(error):
                self.showError(describedBy: error)
            }
        }
    }
    
    private func setup(_ achievements: [AbstractAchievement]) {
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            NSLayoutConstraint.deactivate($0.constraints)
            $0.removeFromSuperview()
        }
        achievements.forEach(add(achievement:))
    }
    
    private func add(achievement: AbstractAchievement) {
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
