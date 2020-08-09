//
//  AddImageCell.swift
//  HabitTracker
//
//  Created by Daulet on 6/16/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class AddImageCell: UICollectionViewCell {
    
    
    @IBOutlet var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.applyDropShadow()
    }
    
}
