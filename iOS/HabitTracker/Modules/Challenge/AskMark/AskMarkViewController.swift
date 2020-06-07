//
//  AskMarkViewController.swift
//  HabitTracker
//
//  Created by Daulet on 6/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

class AskMarkViewController: UIViewController {

    @IBOutlet var addButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        addButton.round()
        addButton.applyDropShadow(color: ColorName.uiBlue.color,
                               opacity: 1,
                               offset: CGSize(width: 0, height: 4),
                               radius: 20,
                               scale: true)
        setBackButton(style: .orange)
        title = "Ask Mark"
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = ColorName.uiBlue.color
        navigationController?.navigationBar.roundCorners([.bottomLeft, .bottomRight], radius: 24)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: FontFamily.Gilroy.medium.font(size: 24)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
    }
    
}
