//
//  StatisticsViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/10/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import Charts

final class StatisticsViewController: UIViewController {

    var lineChartEntry = [ChartDataEntry]()
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var chartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.layer.backgroundColor = UIColor.clear.cgColor
        containerView.applyDropShadow()
        view.clipsToBounds = false
        containerView.clipsToBounds = false
    }
    
}
