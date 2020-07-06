//
//  SelectImageCell.swift
//  HabitTracker
//
//  Created by Daulet on 6/16/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class SelectImageCell: UICollectionViewCell {
    
    var onDelete: EmptyClosure?
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.applyDropShadow()
    }
    
    func configure(image: UIImage?) {
        imageView.image = image
    }
    
    @IBAction
    private func deleteButtonDidPressed() {
        // TODO: убрать эту хуйню
        deleteButton.isUserInteractionEnabled = false
        onDelete?()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400)) {
            self.deleteButton.isUserInteractionEnabled = true
        }
    }
    
}

