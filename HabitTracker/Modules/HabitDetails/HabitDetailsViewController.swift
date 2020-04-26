//
//  HabitDetailsViewController.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    lazy var gapView = UIView(frame: .zero)
    @IBOutlet var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func setupViews() {
        stackView.addArrangedSubview(gapView)
        stackView.setCustomSpacing(16, after: gapView)
        
        let titleInputView = BaseInputView(frame: .zero)
        titleInputView.setup(title: "Title", placeholder: "Enter title")
        
        stackView.addArrangedSubview(titleInputView)
        stackView.setCustomSpacing(4, after: titleInputView)
        
        let notesInputView = BaseInputView(frame: .zero)
        notesInputView.setup(title: "Notes", placeholder: "Description")
        stackView.addArrangedSubview(notesInputView)
        stackView.setCustomSpacing(4, after: notesInputView)
        
        let durationView = DurationView(frame: .zero)
        durationView.setup(title: "Duration")
        stackView.addArrangedSubview(durationView)
        stackView.setCustomSpacing(4, after: durationView)
    }

}
