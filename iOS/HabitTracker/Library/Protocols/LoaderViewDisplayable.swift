//
//  ViewLoadable.swift
//  MoveOn
//
//  Created by Daulet on 13/07/2019.
//  Copyright © 2019 daukabase. All rights reserved.
//

import PinLayout
import UIKit


protocol LoaderViewDisplayable {
    func startLoading(isTransparentBackground: Bool)
    func endLoading()
}

private enum ViewLoadableConstants {
    static let loadingIndicatorIdentifier = "loading_indicator"
}

final class LodingView: UIView {
    
    var isTransparentBackground: Bool = false {
        didSet {
            backgroundColor = isTransparentBackground ? .clear : .white
            guard isTransparentBackground else {
                return
            }
            containerView.applyDropShadow()
        }
    }
    
    private lazy var animationView: UIActivityIndicatorView = {
        let animationView = UIActivityIndicatorView()
        
        animationView.startAnimating()
        
        if #available(iOS 13.0, *) {
            animationView.style = .large
        }
        
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        return animationView
    }()
    
    lazy var containerView: UIView = {
        let container = UIView(frame: .zero)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 16
        container.clipsToBounds = true
        container.backgroundColor = .white
        
        return container
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(animationView)
        
        animationView.addSubview(containerView)
        animationView.sendSubviewToBack(containerView)
        
        animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: animationView.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: animationView.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        isTransparentBackground = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LoaderViewDisplayable where Self: UIViewController {

    func startLoading(isTransparentBackground: Bool = false) {
        view.isUserInteractionEnabled = false
        removeAllExtraLoders()
        
        let animationView = LodingView(frame: .zero)
        animationView.accessibilityIdentifier = ViewLoadableConstants.loadingIndicatorIdentifier
        animationView.isTransparentBackground = isTransparentBackground
        view.addSubview(animationView)
        
        animationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        animationView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        animationView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }

    func endLoading() {
        view.isUserInteractionEnabled = true
        removeAllExtraLoders()
    }
    
    private func removeAllExtraLoders() {
        for view in view.subviews {
            if
                let loadingIndicator = view as? LodingView,
                loadingIndicator.accessibilityIdentifier == ViewLoadableConstants.loadingIndicatorIdentifier
            {
                loadingIndicator.removeFromSuperview()
            }
        }
    }

}
