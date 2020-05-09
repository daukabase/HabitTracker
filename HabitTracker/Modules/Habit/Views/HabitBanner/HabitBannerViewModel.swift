//
//  HabitBannerViewModel.swift
//  HabitTracker
//
//  Created by Daulet on 5/10/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

struct HabitBannerViewModel {
    
    let text = "Congratulations!\n You have a "
    let text2 = "new record."
    
    private var descriptionNormalTextAttributes: [StringAttribute] = [
        .foregroundColor(ColorName.textSecondary.color),
        .aligment(.center),
        .lineHeight(17, font: FontFamily.Gilroy.regular.font(size: 14))
    ]
    private var descriptionHighlighedTextAttributes: [StringAttribute] = [
        .foregroundColor(ColorName.uiOrange.color),
        .aligment(.center),
        .lineHeight(17, font: FontFamily.Gilroy.regular.font(size: 14))
    ]
    
    var descriptionAttributed: NSAttributedString? {
        let attributedText = NSMutableAttributedString()
        
        attributedText.append(descriptionText.with(attributes: descriptionNormalTextAttributes))
        attributedText.append(
            descriptionHighlightedText.with(
                attributes: descriptionHighlighedTextAttributes
            )
        )
        
        return attributedText
    }
    
    let titleText: String
    let descriptionText: String
    let descriptionHighlightedText: String
    
    init(days: Int,
         descriptionText: String = "Congratulations!\n You have a",
         descriptionHighlightedText: String = " new record.") {
        self.titleText = "\(days) days"
        self.descriptionText = descriptionText
        self.descriptionHighlightedText = descriptionHighlightedText
    }
    
}
