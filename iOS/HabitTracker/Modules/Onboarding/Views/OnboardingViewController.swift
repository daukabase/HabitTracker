//
//  OnboardingViewController.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class OnboardingViewController: UIViewController {

    struct PresentationInfo {
        let image: UIImage?
        let title: String?
        let description: String?
    }
    
    @IBOutlet private var stackView: UIStackView!
    private var index: Int
    private let page: OnboardingPage
    
    init(with page: OnboardingPage, index: Int) {
        self.page = page
        self.index = index
        
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureContent()
    }
    
    private func configureContent() {
        switch page.type {
        case .challenge:
            setupPresentation(info: .init(image: Asset.onboarding1.image,
                                          title: L10n.Onboarding.Challenge.title,
                                          description: L10n.Onboarding.Challenge.description),
                              to: stackView)
        case .goal:
            setupPresentation(info: .init(image: Asset.onboarding1.image,
                                          title: L10n.Onboarding.Goal.title,
                                          description: L10n.Onboarding.Goal.description),
                              to: stackView)
        case .track:
            setupPresentation(info: .init(image: Asset.onboarding1.image,
                                          title: L10n.Onboarding.Track.title,
                                          description: L10n.Onboarding.Track.description),
                              to: stackView)
        case .auth:
            UserDefaultsStorage.isOnboardingCompleted = true
            setupPresentationAuth(info: .init(image: Asset.onboarding1.image,
                                              title: L10n.Onboarding.Auth.title,
                                              description: L10n.Onboarding.Auth.description),
                                  to: stackView)
        }
    }
    
    private func setupPresentationAuth(info: PresentationInfo, to stackView: UIStackView) {
        let lastSubview = setupPresentation(info: info, to: stackView)
        stackView.setCustomSpacing(38, after: lastSubview)
        
        let buttonContainer = UIView(frame: .zero)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        button.autoresizingMask = [.flexibleWidth]
        button.title = "Sign up"
        button.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        button.apply(style: .orange)
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        
        buttonContainer.addSubview(button)
        buttonContainer.snp.makeConstraints { (make) in
            make.edges.equalTo(button)
        }
        
        let buttonShadowColor = UIColor(red: 254/255,
                                        green: 128/255,
                                        blue: 92/255,
                                        alpha: 0.24)
        
        buttonContainer.layer.backgroundColor = UIColor.clear.cgColor
        buttonContainer.applyDropShadow(color: buttonShadowColor,
                               opacity: 1,
                               offset: CGSize(width: 0, height: 4),
                               radius: 20,
                               scale: true)
        
        stackView.addArrangedSubview(button)
        stackView.setCustomSpacing(16, after: button)
        
        let attributes: [StringAttribute] = [
            .font(FontFamily.Gilroy.regular.font(size: 13)),
            .foregroundColor(ColorName.uiBlue.color)
        ]
        let label = ActionableLabel()
        label.append(text: "Already have an account?")
        label.append(text: " Sign in ", attributes: attributes) { [weak self] in
            self?.routeToSignIn()
        }
        
        stackView.addArrangedSubview(label)
    }
    
    @discardableResult
    private func setupPresentation(info: PresentationInfo, to stackView: UIStackView) -> UIView {
        let imageView = UIImageView(image: info.image)
        imageView.contentMode = .scaleAspectFit
        
        stackView.addArrangedSubview(imageView)
        stackView.setCustomSpacing(48, after: imageView)
        
        let titleLabel = UILabel(frame: .zero)
        titleLabel.font = FontFamily.Gilroy.medium.font(size: 18)
        titleLabel.textColor = ColorName.uiBlue.color
        titleLabel.textAlignment = .center
        titleLabel.text = info.title
        
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(15, after: titleLabel)
        
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.font = FontFamily.Gilroy.regular.font(size: 14)
        descriptionLabel.textColor = ColorName.uiGraySecondary.color
        descriptionLabel.numberOfLines = .zero
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = info.description
        
        stackView.addArrangedSubview(descriptionLabel)
        
        return descriptionLabel
    }
    
    func getIndex() -> Int {
        return index
    }
    
    private func darkModeEnabled() -> Bool {
        guard #available(iOS 12.0, *),
            self.traitCollection.userInterfaceStyle == .dark else {
            return false
        }
        
        return true
    }
    
    private func routeToMainScreen() {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.rootViewController = UINavigationController(rootViewController: HomeViewController())
        
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {},
                          completion: nil)
    }
    
    private func routeToSignIn() {
        guard let controller = UIStoryboard.instantiate(ofType: NumberRegistrationViewController.self) else {
            return
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func routeToSignUp() {
        guard let controller = UIStoryboard.instantiate(ofType: NumberRegistrationViewController.self) else {
            return
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc
    private func didTapSignUpButton() {
        routeToSignUp()
    }
    
}
