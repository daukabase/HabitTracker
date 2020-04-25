//
//  HomeViewController.swift
//  HabitTracker
//
//  Created by Daulet on 4/5/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import SegementSlide

class HomeViewController: SegementSlideViewController {

    override var titlesInSwitcher: [String] {
        return ["Habits", "Challenge", "Program"]
    }

    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        return UIStoryboard.instantiate(ofType: HabitsViewController.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isHidden = true
        
        reloadData()
        scrollToSlide(at: 0, animated: false)
    }

}
