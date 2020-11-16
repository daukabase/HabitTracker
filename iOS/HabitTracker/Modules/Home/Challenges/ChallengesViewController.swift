//
//  ChallengesViewController.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/21/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import SegementSlide

final class ChallengesViewController: UIViewController {
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        
        label.font = FontFamily.Gilroy.bold.font(size: 21)
        label.numberOfLines = .zero
        label.textColor = ColorName.uiOrange.color
        label.text = L10n.Home.Challenge.Message.comingSoon
        label.textAlignment = .center
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY).offset(-86)
            make.width.equalTo(UIScreen.main.bounds.width * 2 / 3)
        }
    }
    
}

extension ChallengesViewController: SegementSlideContentScrollViewDelegate {
    // MARK: - SegementSlideContentScrollViewDelegate
}
