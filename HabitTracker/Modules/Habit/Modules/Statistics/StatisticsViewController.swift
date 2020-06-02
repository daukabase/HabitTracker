//
//  StatisticsViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/10/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.layer.backgroundColor = UIColor.clear.cgColor
        containerView.applyDropShadow()
        view.clipsToBounds = false
        containerView.clipsToBounds = false
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
