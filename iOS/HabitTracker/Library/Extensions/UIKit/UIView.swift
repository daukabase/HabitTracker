//
//  UIView.swift
//  Unicredit
//
//  Created by Ivan Smetanin on 31/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UIView {

    // MARK: - Constants

    enum Constants {
        static let defaultCornerRadius: CGFloat = 3
        static let animationTime: TimeInterval = 0.3
        static let highlightAnimationTime: TimeInterval = 0.2
    }

    enum Corner {
        case lowerRight // Lower left corner
        case upperRight // Upper right corner
        case upperLeft // Upper left corner
        case lowerLeft // Lower right corner
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - Methods
    func round() {
        layer.cornerRadius = bounds.height / 2
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat = Constants.defaultCornerRadius) {
        if #available(iOS 11.0, *) {
            layer.cornerRadius = radius
            layer.maskedCorners = corners.caCornerMaskValue
        } else {
            let path = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }

    /// Loads view from nib and sets to the view as a subview
    ///
    /// May be used for initializing views that have layout in xibs
    ///
    /// Example:
    /// ```
    /// init() {
    ///     super.init(frame: CGRect.zero)
    ///     initFromNib()
    /// }
    ///
    /// required init?(coder aDecoder: NSCoder) {
    ///     super.init(coder: aDecoder)
    ///     initFromNib()
    /// }
    /// ```
    @discardableResult
    func initFromNib<T: UIView>() -> T? {
        guard let contentView: T = loadFromNib() else {
            return nil
        }
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = backgroundColor

        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
                contentView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: self.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        }
        return contentView
    }

    /// Instantiates view from a nib file
    func loadFromNib<T: UIView>() -> T? {
        let selfType = type(of: self)
        let bundle = Bundle(for: selfType)
        let nibName = String(describing: selfType)
        let nib = UINib(nibName: nibName, bundle: bundle)

        let view = nib.instantiate(withOwner: self, options: nil).first as? T
        return view
    }

    /// Applies drop shadow effect to the view
    ///
    /// - Parameters:
    ///   - color: Shadow color
    ///   - opacity: Shadow opacity
    ///   - offset: Shadow offset
    ///   - radius: Shadow radius
    ///   - scale: Pass **true** to apply `UIScreen.main.scale` to the layer
    func applyDropShadow(color: UIColor = .black,
                         opacity: Float = 0.1,
                         offset: CGSize = CGSize(width: 0, height: 5),
                         radius: CGFloat = 10,
                         scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius

        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
    func applyDropShadow(x: CGFloat = 0,
                         y: CGFloat = 16,
                         blur: CGFloat = 40,
                         spread: CGFloat = 0,
                         color: UIColor = ColorName.uiGrayPrimary.color,
                         alpha: Float = 0.2) {
        var shadowPath: CGPath?
        
        if spread != 0 {
            let rect = bounds.insetBy(dx: -spread, dy: -spread)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
        
        masksToBounds = false
        
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2.0
        layer.shadowPath = shadowPath
        layer.shouldRasterize = false
    }
    
    func applyDropShadow(with model: ShadowModel) {
        applyDropShadow(color: UIColor(cgColor: model.color),
                        opacity: model.opacity,
                        offset: model.offset,
                        radius: model.radius,
                        scale: model.scale)
    }

    /// Adds this view as a subview to a given view uses constraints
    func attach(to view: UIView, topOffset: CGFloat = 0,
                bottomOffset: CGFloat = 0,
                leftOffset: CGFloat = 0,
                rightOffset: CGFloat = 0) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: topOffset),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomOffset),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftOffset),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightOffset)
        ])
    }

    /// Returns corners that should be cornered to fit provided conditions
    static func cornersToRound(shouldRoundTop: Bool, shouldRoundBottom: Bool) -> UIRectCorner {
        if shouldRoundTop && shouldRoundBottom {
            return [.topLeft, .topRight, .bottomLeft, .bottomRight]
        } else if shouldRoundTop {
            return [.topLeft, .topRight]
        } else if shouldRoundBottom {
            return [.bottomLeft, .bottomRight]
        } else {
            return []
        }
    }

    /// Highlights view. In default implementation just sets gray background.
    ///
    /// - Warning: Calls in animation block when uses with `setupHighlightListening()`.
    @objc
    func highlight() {
        backgroundColor = ColorName.uiGrayPrimary.color
    }

    /// Unhighlights view. In default implementation just sets white background.
    ///
    /// - Warning: Calls in animation block when uses with `setupHighlightListening()`.
    @objc
    func unhighlight() {
        backgroundColor = ColorName.uiWhite.color
    }

    /// Setups listening to highlight gestures.
    ///
    /// Don't forget to override `unhighlight()` and `highlight()` methods to
    /// provide custom behavior of appearance change.
    func setupHighlightListening() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(longPressGestureRecognizerAction(recognizer:))
        )
        longPressGestureRecognizer.minimumPressDuration = 0.05
        longPressGestureRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(longPressGestureRecognizer)
    }

    // MARK: - Actions

    @objc
    private func longPressGestureRecognizerAction(recognizer: UILongPressGestureRecognizer) {
        UIView.animate(withDuration: Constants.animationTime) {
            switch recognizer.state {
            case .began, .changed:
                let location = recognizer.location(in: self)
                if self.bounds.contains(location) {
                    self.highlight()
                } else {
                    self.unhighlight()
                }
            case .cancelled, .ended, .failed, .possible:
                self.unhighlight()
            @unknown default:
                self.unhighlight()
            }
        }
    }

    // MARK: - Helpers

    private func lowerLeftTriangle(size: CGSize) -> UIBezierPath {
        let path = UIBezierPath()

        path.move(to: .zero)
        path.addLine(to: CGPoint(x: size.width, y: size.height))
        path.addLine(to: CGPoint(x: 0, y: size.height))
        path.close()

        return path
    }

    private func upperRightTriangle(size: CGSize) -> UIBezierPath {
        let path = UIBezierPath()

        path.move(to: .zero)
        path.addLine(to: CGPoint(x: size.width, y: 0))
        path.addLine(to: CGPoint(x: size.width, y: size.height))
        path.close()

        return path
    }

    private func upperLeftTriangle(size: CGSize) -> UIBezierPath {
        let path = UIBezierPath()

        path.move(to: .zero)
        path.addLine(to: CGPoint(x: size.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: size.height))
        path.close()

        return path
    }

    private func lowerRightTriangle(size: CGSize) -> UIBezierPath {
        let path = UIBezierPath()

        path.move(to: CGPoint(x: size.width, y: 0))
        path.addLine(to: CGPoint(x: size.width, y: size.height))
        path.addLine(to: CGPoint(x: 0, y: size.height))
        path.close()

        return path
    }

}
