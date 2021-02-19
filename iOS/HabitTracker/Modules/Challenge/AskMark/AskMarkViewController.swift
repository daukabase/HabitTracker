//
//  AskMarkViewController.swift
//  HabitTracker
//
//  Created by Daulet on 6/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import SnapKit

final class AskMarkViewController: UIViewController {

    @IBOutlet var sendButton: UIButton!
    @IBOutlet var textView: UITextView!
    @IBOutlet var textContainerView: UIView!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var challengeTitleLabel: UILabel!
    @IBOutlet var membersImagesView: UIView!
    @IBOutlet var progresLabel: UILabel!
    @IBOutlet var addedImagesView: UIView!
    
    @IBOutlet var backgroundedViews: [UIView]!
    
    lazy var selectedImagesController: UIViewController = {
//        guard let controller = UIStoryboard.instantiate(ofType: SelectImagesViewController.self) else {
//            fatalError()
//        }
        
        return UIViewController()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        setupColors()
    }

    private func setupColors() {
        backgroundedViews.forEach { (view) in
            view.backgroundColor = .clear
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.roundCorners([.bottomLeft, .bottomRight], radius: 24)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: FontFamily.Gilroy.medium.font(size: 18)!,
            NSAttributedString.Key.foregroundColor: ColorName.textBlack.color
        ]
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = ColorName.uiWhite.color
        navigationController?.navigationBar.tintColor = ColorName.uiGrayPrimary.color
    }
    
    private func commonInit() {
        title = "Ask Mark"
        
        sendButton.round()
        sendButton.apply(style: .blue)
        setBackButton(style: .orange)
        
        textContainerView.layer.backgroundColor = UIColor.clear.cgColor
        textContainerView.applyDropShadow()
        
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        textView.cornerRadius = 10
        textView.masksToBounds = true
        
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        addedImagesView.translatesAutoresizingMaskIntoConstraints = true
        addedImagesView.addSubview(selectedImagesController.view)
        addChild(selectedImagesController)
    }
    
    private func setupLayout() {
        selectedImagesController.view.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
}
