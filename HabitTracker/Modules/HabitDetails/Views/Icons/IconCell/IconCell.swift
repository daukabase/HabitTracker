//
//  IconCell.swift
//  HabitTracker
//
//  Created by Daulet on 5/9/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class IconCell: UICollectionViewCell {
    
    lazy var iconImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        
        image.contentMode = .center
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func commonInit() {
        addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    func configure(model: IconCellViewModel) {
        self.iconImageView.image = model.habitIcon.icon.withRenderingMode(.alwaysTemplate)
        udpateImageColor(model: model)
    }
    
    func udpateImageColor(model: IconCellViewModel) {
        iconImageView.tintColor = model.isSelected ? model.selectedColor : model.defaultColor
    }
    
}
