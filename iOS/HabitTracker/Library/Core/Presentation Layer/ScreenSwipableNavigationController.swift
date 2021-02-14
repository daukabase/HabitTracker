//
//  ScreenSwipableNavigationController.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/14/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import SloppySwiper

class ScreenSwipableNavigationController: UINavigationController {
    
    var swiper: SloppySwiper?
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        self.swiper = SloppySwiper(navigationController: self)
        self.delegate = swiper
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
