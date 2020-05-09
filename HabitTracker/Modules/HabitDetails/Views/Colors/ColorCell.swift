
//
//  ColorCell.swift
//  HabitTracker
//
//  Created by Daulet on 5/1/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class ColorCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            doneImageView.isHidden = !isSelected
        }
    }
    
    lazy var imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var doneImageView: UIImageView = {
        let image = UIImageView(image: Asset.done.image)
        image.contentMode = .center
        return image
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.round()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageView)
        contentView.addSubview(doneImageView)
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(91)
            make.height.equalTo(64)
        }
        doneImageView.snp.makeConstraints { (make) in
            make.center.equalTo(imageView)
        }
        
        imageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setup(color: UIColor) {
        imageView.image = UIImage.image(with: color)
    }
    
    func setup(colorHex: String) {
        setup(color: UIColor(hexString: colorHex))
    }
    
}
