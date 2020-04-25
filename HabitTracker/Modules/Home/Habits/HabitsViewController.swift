//
//  HabitsViewController.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import SegementSlide


final class HabitsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var items: [Habit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension HabitsViewController: SegementSlideContentScrollViewDelegate {
    
}
