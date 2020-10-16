
//
//  AchievementView.swift
//  HabitTracker
//
//  Created by Daulet on 5/31/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

protocol AbstractAchievement {
    var title: NSAttributedString? { get set }
    var description: String { get set }
    var image: UIImage? { get set }
}

struct GoalAchievement: AbstractAchievement {
    
    var title: NSAttributedString?
    var description: String
    var image: UIImage?
    
    init(completedDays: Int, totalDays: Int, description: String = "Goal", image: UIImage = Asset.goal.image) {
        let indicatorValue = NSMutableAttributedString()
        let first: [StringAttribute] = [
            .font(FontFamily.Gilroy.semibold.font(size: 24)),
            .foregroundColor(ColorName.icons.color)
        ]
        let second: [StringAttribute] = [
            .font(FontFamily.Gilroy.semibold.font(size: 18)),
            .foregroundColor(ColorName.icons.color)
        ]
        
        let firstText = "\(completedDays)".with(attributes: first)
        let secondText = "/\(totalDays) days".with(attributes: second)
        
        indicatorValue.append(firstText)
        indicatorValue.append(secondText)
        
        self.title = indicatorValue
        self.description = description
        self.image = image
    }
    
}

struct CommonAchievement: AbstractAchievement {
    
    static func getCurrentStreak(for days: Int) -> AbstractAchievement {
        return CommonAchievement(numberOfDays: days,
                                 description: "Current Streak",
                                 image: Asset.order.image)
    }
    
    static func getLongestStreak(for days: Int) -> AbstractAchievement {
        return CommonAchievement(numberOfDays: days,
                                 description: "Current Streak",
                                 image: Asset.order.image)
    }
    
    static func getTotalDone(for days: Int) -> AbstractAchievement {
        return CommonAchievement(numberOfDays: days,
                                 description: "Total done",
                                 image: Asset.guard.image)
    }
    
    var title: NSAttributedString?
    var description: String
    var image: UIImage?
    
    init(numberOfDays: Int, description: String, image: UIImage) {
        let indicatorValue = NSMutableAttributedString()
        let first: [StringAttribute] = [
            .font(FontFamily.Gilroy.semibold.font(size: 24)),
            .foregroundColor(ColorName.icons.color)
        ]
        let second: [StringAttribute] = [
            .font(FontFamily.Gilroy.semibold.font(size: 18)),
            .foregroundColor(ColorName.icons.color)
        ]
        
        let firstText = "\(numberOfDays)".with(attributes: first)
        let secondText = " days".with(attributes: second)
        
        indicatorValue.append(firstText)
        indicatorValue.append(secondText)
        
        self.title = indicatorValue
        self.description = description
        self.image = image
    }
    
}

final class AchievementView: UIView {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        let view = initFromNib()
        
        view?.applyDropShadow()
        view?.backgroundColor = .clear
        
        descriptionLabel.font = FontFamily.Gilroy.regular.font(size: 14)
        descriptionLabel.textColor = ColorName.textSecondary.color
    }
    
    func configure(model: AbstractAchievement) {
        self.imageView.image = model.image
        self.titleLabel.attributedText = model.title
        self.descriptionLabel.text = model.description
    }
    
}
