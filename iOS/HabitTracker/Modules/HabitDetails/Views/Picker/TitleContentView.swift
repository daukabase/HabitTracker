//
//  TitleContentView.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/22/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import UIKit

class TitleContentView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = FontFamily.Gilroy.regular.font(size: 16)
        label.textColor = ColorName.uiOrange.color
        
        return label
    }()
    
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        
        label.font = FontFamily.Gilroy.medium.font(size: 16)
        label.textColor = ColorName.textPrimary.color
        
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView(frame: .zero)
        
        view.backgroundColor = ColorName.uiBlueSecondary.color
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        [titleLabel, dataLabel, lineView].forEach(addSubview)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(8)
        }
        dataLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.centerY.equalTo(titleLabel)
        }
        snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }

    func enable() {
        dataLabel.textColor = ColorName.textPrimary.color
    }
    
    func disable() {
        dataLabel.textColor = ColorName.textSecondary.color
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
    
    func set(description: String) {
        self.dataLabel.text = description
    }
    
}

