//
//  SettingsTableViewCell.swift
//  productamount
//
//  Created by Nurbek Ismagulov on 10/26/19.
//  Copyright © 2019 Nurbek Ismagulov. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    private var topSeparatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = ColorName.uiGraySecondary.color.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.textColor = ColorName.textBlack.color
        label.font = FontFamily.Gilroy.medium.font(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var bottomSeparatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorName.uiGraySecondary.color.withAlphaComponent(0.3)
        return view
    }()
    
    private var rightImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        [topSeparatorLine, label, bottomSeparatorLine, rightImageView].forEach(contentView.addSubview)
        
        topSeparatorLine.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        topSeparatorLine.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topSeparatorLine.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        topSeparatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        bottomSeparatorLine.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bottomSeparatorLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomSeparatorLine.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bottomSeparatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        label.topAnchor.constraint(equalTo: topSeparatorLine.bottomAnchor, constant: 15).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomSeparatorLine.topAnchor, constant: -15).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 45).isActive = true
        label.rightAnchor.constraint(equalTo: rightImageView.leftAnchor, constant: -32).isActive = true
        
        rightImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        rightImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        rightImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        rightImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -45).isActive = true
    }
    
    func set(text: String, image: UIImage? = nil) {
        label.text = text
        rightImageView.image = image
    }
    
    func enableEmpty() {
        topSeparatorLine.isHidden = true
        bottomSeparatorLine.isHidden = true
        backgroundColor = .clear
        selectionStyle = .none
    }
    
}
