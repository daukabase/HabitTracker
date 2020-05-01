
//
//  BackgroundImageCell.swift
//  HabitTracker
//
//  Created by Daulet on 5/1/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class BackgroundImageCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            doneIndicatorView.isHidden = !isSelected
        }
    }
    
    lazy var imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var doneImageView: UIImageView = {
        let image = UIImageView(image: Asset.done.image)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var doneIndicatorView: UIView = {
        let view = UIView(frame: .zero)
        
        view.isHidden = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageView)
        contentView.addSubview(doneIndicatorView)
        
        doneIndicatorView.addSubview(doneImageView)
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(91)
            make.height.equalTo(64)
        }
        doneIndicatorView.snp.makeConstraints { (make) in
            make.edges.equalTo(imageView)
        }
        doneImageView.snp.makeConstraints { (make) in
            make.center.equalTo(doneIndicatorView)
            make.size.equalTo(22)
        }
        
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        
        doneIndicatorView.layer.cornerRadius = 12
        doneIndicatorView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
}
