//
//  NumberConfirmationViewModel.swift
//  MoveOn
//
//  Created by Daulet on 2/2/20.
//  Copyright © 2020 daukabase. All rights reserved.
//

import UIKit

struct NumberConfirmationViewModel {
    
    private enum Constants {
        static let resendInterval = 60
        static let descriptionLineSpacing: CGFloat = 4
    }
    
    
    private var textAttributes: [StringAttribute] {
        return [
            .foregroundColor(ColorName.textSecondary.color),
            .lineHeight(20, font: FontFamily.Gilroy.regular.font(size: 13)),
            .aligment(.center)
        ]
    }
    
    private var numberAttributes: [StringAttribute] {
        return [
            .foregroundColor(ColorName.textBlack.color),
            .lineHeight(20, font: FontFamily.Gilroy.medium.font(size: 14)),
            .aligment(.center)
        ]
    }
    
    let phoneNumber: String
    let codeLength: Int = 4
    let descriptionAttributed: NSAttributedString?
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
        
        let descriptionAttributed = NSMutableAttributedString()
        let textAttributes: [StringAttribute] = [
            .foregroundColor(ColorName.textSecondary.color),
            .lineHeight(20, font: FontFamily.Gilroy.regular.font(size: 13)),
            .aligment(.center)
        ]
        let numberAttributes: [StringAttribute] = [
            .foregroundColor(ColorName.textBlack.color),
            .lineHeight(20, font: FontFamily.Gilroy.medium.font(size: 14)),
            .aligment(.center)
        ]
        
        descriptionAttributed.append("An \(codeLength)-digit verification code has \nbeen sent to ".with(attributes: textAttributes))
        descriptionAttributed.append(phoneNumber.with(attributes: numberAttributes))
        
        self.descriptionAttributed = descriptionAttributed
    }
    
    
    
}
