//
//  MessageBanner.swift
//  MoveOn
//
//  Created by Daulet on 06/02/2019.
//  Copyright © 2019 daukabase. All rights reserved.
//

import UIKit

protocol MessageBannerDelegate: class {
    func messageDidShow(_ banner: MessageBanner)
    func messageDidHide(_ banner: MessageBanner)
}

enum BackgroundStyle {
    /// Blure view.
    case blured(UIBlurEffect)
    /// Only with background color.
    case colored(UIColor)
}

/// Animation style.
enum AnimationStyle {
    /// Simple animation. Message move linearly.
    case normal
    /// After showing message jump on custom amplitude.
    case rigid(CGFloat)
    /// After showing message stretched on custom hieght.
    case rubbered(CGFloat)
}

class MessageBanner {

    // MARK: - Constants

    private enum Constants {
        static let defaultShowDelay: TimeInterval = 3
        static let defaultShowAnimationDuration: TimeInterval = 0.5
        static let defaultHideAnimationDuration: TimeInterval = 0.5
        static let defaultAnimationDurationOfPart: TimeInterval = 0.2
        static let defaultWidthForPad: CGFloat = 400
        static let textInsets: UIEdgeInsets = UIEdgeInsets(top: 24, left: 16, bottom: 16, right: 16)
    }

    // MARK: - Fileprivatе properties

    // swiftlint:disable implicitly_unwrapped_optional
    private var messageLabel: UILabel!
    fileprivate var contentView: UIView!
    private let backgroundStyle: BackgroundStyle
    private var parentView: UIView!
    private var topLabelConstraint: NSLayoutConstraint!
    // swiftlint:enable implicitly_unwrapped_optional

    private var isClosing: Bool = false
    private var closingWithDelayWorkItem: DispatchWorkItem?

    // MARK: - Public observable properties

    /// Message text.
    public var messageText: String = "" {
        didSet {
            messageLabel.text = messageText
        }
    }

    /// Attributed message text.
    public var messageAttributedText: NSAttributedString = NSAttributedString(string: "") {
        didSet {
            messageLabel.attributedText = messageAttributedText
        }
    }

    /// Message text color.
    public var messageForegroundColor: UIColor = UIColor.black {
        didSet {
            messageLabel.textColor = messageForegroundColor
        }
    }

    /// Message text font.
    public var messageFont: UIFont = UIFont.systemFont(ofSize: 8) {
        didSet {
            messageLabel.font = messageFont
        }
    }

    // MARK: - Public properties

    /// Time between when the message appeared and when the message began to hide
    public var showDelay: TimeInterval = Constants.defaultShowDelay
    /// Duration of the animation message display
    public var showAnimationDuration: TimeInterval = Constants.defaultShowAnimationDuration
    /// Duration of the animation message hide
    public var hideAnimationDuration: TimeInterval = Constants.defaultHideAnimationDuration
    /// Options for the message display
    public var showAnimationOptions: UIView.AnimationOptions = []
    /// Options for the message hide
    public var hideAnimationOptions: UIView.AnimationOptions = []
    /// Animation style
    public var animationStyle: AnimationStyle = .normal

    public weak var delegate: MessageBannerDelegate?

    public init(with backgroundStyle: BackgroundStyle = .colored(Color.red)) {
        self.backgroundStyle = backgroundStyle
        configureView()
    }

    func show(with view: UIView? = UIApplication.shared.keyWindow) {
        guard let guardedView = view else {
            debugPrint("Key window not found")
            return
        }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        guardedView.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(
                equalTo: guardedView.leadingAnchor
            ),
            contentView.trailingAnchor.constraint(
                    equalTo: guardedView.trailingAnchor
            )
        ])

        contentView.layoutIfNeeded()

        guardedView.setNeedsUpdateConstraints()
        guardedView.setNeedsLayout()
        guardedView.layoutIfNeeded()

        contentView.frame.origin.y = -contentView.frame.size.height
        if #available(iOS 11, *) {
            topLabelConstraint.constant += contentView.safeAreaInsets.top
            contentView.frame.size.height += contentView.safeAreaInsets.top
        }
        showAnimationStart()
        parentView = guardedView
        delegate?.messageDidShow(self)
    }

    func closeWithDelay() {
        let task = DispatchWorkItem { [weak self] in
            self?.closeImmidiately()
        }
        let deadline = DispatchTime.now() + showDelay
        DispatchQueue.main.asyncAfter(deadline: deadline, execute: task)
        closingWithDelayWorkItem = task
    }

    func closeImmidiately() {
        guard !isClosing else {
            return
        }
        closingWithDelayWorkItem?.cancel()
        isClosing = true
        UIView.animate(
            withDuration: hideAnimationDuration,
            delay: 0,
            options: hideAnimationOptions,
            animations: {
                let height = self.contentView.frame.height
                self.contentView.transform = CGAffineTransform(translationX: 0, y: -height)
            },
            completion: { isCompleted in
                if isCompleted {
                    self.parentView.willRemoveSubview(self.contentView)
                    self.contentView.removeFromSuperview()
                    self.delegate?.messageDidHide(self)
                    self.isClosing = false
                }
            }
        )
    }
}

private extension MessageBanner {

    func configureView() {
        messageLabel = UILabel()
        switch backgroundStyle {
        case .blured(let effect):
            let view = UIVisualEffectView(effect: effect)
            view.contentView.addSubview(messageLabel)
            contentView = view
        case .colored(let color):
            contentView = UIView()
            contentView.backgroundColor = color
            contentView.addSubview(messageLabel)
        }

        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textAlignment = .center

        topLabelConstraint = messageLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: Constants.textInsets.top
        )

        NSLayoutConstraint.activate([
            topLabelConstraint,
            messageLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.textInsets.left
            ),
            messageLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.textInsets.right
            ),
            messageLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Constants.textInsets.bottom
            )
        ])

        let gr = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        contentView.addGestureRecognizer(gr)
        contentView.isUserInteractionEnabled = true

    }

    @objc
    private func handlePan(gesture: UIPanGestureRecognizer) {
        guard isClosing == false else {
            return
        }

        // If velocity is too high we need to close banner
        let isNeedForceClose: Bool = gesture.velocity(in: contentView).y < (-contentView.frame.size.height * 8)
        let translationVertical = gesture.translation(in: contentView).y

        if (gesture.state == .ended || gesture.state == .cancelled) &&
            !isNeedForceClose && translationVertical < 0 {
            closeImmidiately()
            return
        }

        if isNeedForceClose {
            closeImmidiately()
        } else {
            handleVerticalPanGestureTranslation(translation: translationVertical)
        }
    }

    private func handleVerticalPanGestureTranslation(translation: CGFloat) {
        guard
            translation < 0,
            let statusBar = UIApplication.shared.statusBarView
        else {
                return
        }
        // self.topConstraint?.constant = translation
        contentView.transform = CGAffineTransform(translationX: 0, y: translation)
        if translation < -contentView.frame.size.height + statusBar.frame.height {
            contentView.transform = CGAffineTransform(translationX: 0, y: -contentView.frame.size.height)
            delegate?.messageDidHide(self)
        }
        contentView.superview?.layoutIfNeeded()
    }

}

// MARK: - Animations

private extension MessageBanner {

    func showAnimationStart() {
        UIView.animate(
            withDuration: showAnimationDuration,
            delay: 0.0,
            options: showAnimationOptions,
            animations: {
                self.contentView.frame = CGRect(
                    x: self.contentView.frame.origin.x,
                    y: 0,
                    width: self.contentView.frame.width,
                    height: self.contentView.bounds.size.height
                )
            },
            completion: { _ in
                self.closeWithDelay()
            }
        )
    }

    func startRubberedAnimation(scale: CGFloat) {
        UIView.animate(
            withDuration: Constants.defaultAnimationDurationOfPart,
            delay: 0.0,
            options: .curveEaseIn,
            animations: {
                self.contentView.transform = self.contentView.transform.scaledBy(x: scale, y: scale)
            },
            completion: { _ in
                self.endRubberedAnimation(scale: scale)
            }
        )
    }

    func startRigidAnimation(amplitude: CGFloat) {
        UIView.animate(
            withDuration: Constants.defaultAnimationDurationOfPart,
            delay: 0.0,
            options: .curveEaseIn,
            animations: {
                self.contentView.transform = self.contentView.transform.translatedBy(x: 0, y: -amplitude)
            },
            completion: { _ in
                self.endRigidAnimation(amplitude: amplitude)
            }
        )
    }

    private func endRubberedAnimation(scale: CGFloat) {
        UIView.animate(
            withDuration: Constants.defaultAnimationDurationOfPart,
            delay: 0.0,
            options: .curveEaseOut,
            animations: {
                self.contentView.transform = self.contentView.transform.scaledBy(x: -scale, y: -scale)
            },
            completion: { _ in
                self.closeWithDelay()
            }
        )
    }

    private func endRigidAnimation(amplitude: CGFloat) {
        UIView.animate(
            withDuration: Constants.defaultAnimationDurationOfPart,
            delay: 0.0,
            options: .curveEaseOut,
            animations: {
                self.contentView.transform = self.contentView.transform.translatedBy(x: 0, y: amplitude)
            },
            completion: { _ in
                self.closeWithDelay()
            }
        )
    }
}

// MARK: - Configuring label

enum MessageBannerType {
    case error
    case info
}

extension MessageBanner {

    convenience init(message: String, type: MessageBannerType = .error) {
        let color: UIColor
        switch type {
        case .error:
            color = ColorName.uiRed.color
        case .info:
            color = ColorName.uiGreen.color
        }
        self.init(with: .colored(color))
        configureLabel(message: message)
    }

    convenience init(message: String, color: UIColor) {
        self.init(with: .colored(color))
        configureLabel(message: message)
    }

    private func configureLabel(message: String) {
        messageForegroundColor = .white
        messageFont = FontFamily.Gilroy.regular.font(size: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .center
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        messageAttributedText = NSAttributedString(string: message, attributes: attributes)
    }

}
