//
//  StatisticsViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/10/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class StatisticsViewController: UIViewController {

    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.clipsToBounds = false
        
        containerView.layer.backgroundColor = UIColor.clear.cgColor
        containerView.applyDropShadow()
        containerView.clipsToBounds = false
    }
    
}
