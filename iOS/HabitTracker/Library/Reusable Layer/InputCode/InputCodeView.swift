//
//  InputCodeView.swift
//  MoveOn
//
//  Created by Daulet on 11/10/2019.
//  Copyright © 2019 daukabase. All rights reserved.
//

import UIKit

final class InputCodeView: UIView {
    
    // MARK: - Nested types
    
    private enum Constants {
        static let defaultItemsSpacing: CGFloat = 24
        static let defaultCodeLength = 4
    }
    
    // MARK: - Properties
    
    var text = "" {
        didSet {
            guard oldValue != text else {
                return
            }
            if text.count == codeLength {
                didFillText?(text)
            }
        }
    }
    
    var itemsSpacing: CGFloat = Constants.defaultItemsSpacing
    var codeLength = Constants.defaultCodeLength {
        didSet {
            guard oldValue != codeLength else {
                return
            }
            setupItems()
        }
    }
    
    var didFillText: Closure<String>?
    
    // MARK: - Private properties
    
    private var items: [InputCodeItemView] = []
    
    // MARK: - Initialization and deinitialization
    
    init() {
        super.init(frame: .zero)
        configureUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - UIView
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var intrinsicContentSize: CGSize {
        let spacingWidth = CGFloat(items.count - 1) * itemsSpacing
        let itemsWidth = items.map { $0.intrinsicContentSize.width }.reduce(CGFloat(0), +)
        let height = items.first?.intrinsicContentSize.height ?? 0
        return CGSize(width: spacingWidth + itemsWidth, height: height)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return intrinsicContentSize
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let itemWidth = items.first?.intrinsicContentSize.width ?? 0
        for (index, item) in items.enumerated() {
            let startInset = CGFloat(index) * (itemsSpacing + itemWidth)
            item.pin
                .top()
                .bottom()
                .start(startInset)
                .end()
                .sizeToFit()
        }
    }
    
    // MARK: - Internal methods
    
    func clear() {
        text = ""
        refreshContent()
    }
    
    // MARK: - Actions
    
    @objc
    private func tapAction() {
        becomeFirstResponder()
    }
    
    // MARK: - Private methods
    
    private func refreshContent() {
        for (index, item) in items.enumerated() {
            if index < text.count {
                let textIndex = text.index(text.startIndex, offsetBy: index)
                let character = text[textIndex]
                item.apply(state: .filled(character: character))
            } else if index == text.count {
                item.apply(state: .active)
            } else {
                item.apply(state: .inactive)
            }
        }
    }
    
    private func configureUI() {
        addGestureRecognizers()
        setupItems()
        refreshContent()
        backgroundColor = .clear
    }
    
    private func addGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupItems() {
        items.forEach {
            $0.removeFromSuperview()
        }
        items.removeAll()
        for _ in 0..<codeLength {
            let item = InputCodeItemView()
            addSubview(item)
            items.append(item)
        }
        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }
    
}

// MARK: - UIKeyInput

extension InputCodeView: UIKeyInput {
    
    var hasText: Bool {
        return !text.isEmpty
    }
    
    func insertText(_ newText: String) {
        guard text.count < codeLength else {
            return
        }
        text.append(newText)
        text = String(text.prefix(codeLength))
        refreshContent()
    }
    
    func deleteBackward() {
        if !text.isEmpty {
            text.removeLast()
        }
        refreshContent()
    }
    
}

// MARK: - UITextInputTraits

// swiftlint:disable unused_setter_value
// swiftlint:disable implicitly_unwrapped_optional
extension InputCodeView: UITextInputTraits {
    
    var autocorrectionType: UITextAutocorrectionType {
        get {
            return .yes
        }
        set {
            assertionFailure()
        }
    }
    
    var keyboardType: UIKeyboardType {
        get {
            return .numberPad
        }
        set {
            assertionFailure()
        }
    }
    
    var textContentType: UITextContentType! {
        get {
            if #available(iOS 12.0, *) {
                return .oneTimeCode
            } else {
                return nil
            }
        }
        set {
            assertionFailure()
        }
    }
    
}

// swiftlint:enable unused_setter_value
// swiftlint:enable implicitly_unwrapped_optional
