//
//  MarkAsDoneViewController.swift
//  HabitTracker
//
//  Created by Daulet on 6/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

class MarkAsDoneViewController: UIViewController {

    @IBOutlet var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sendButton.round()
        sendButton.apply(style: .blue)
        setBackButton(style: .orange)
        title = "Mark As Done"
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
