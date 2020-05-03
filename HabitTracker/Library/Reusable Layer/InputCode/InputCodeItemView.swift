//
//  InputCodeItemView.swift
//  MoveOn
//
//  Created by Daulet on 11/10/2019.
//  Copyright © 2019 daukabase. All rights reserved.
//

import UIKit

final class InputCodeItemView: UIView {
    
    // MARK: - Nested types
    
    enum State {
        case active
        case inactive
        case filled(character: Character)
    }
    
    // MARK: - Subviews
    
    private lazy var codeLabel = UILabel()
    
    // MARK: - Properties
    
    var font: UIFont = FontFamily.Gilroy.regular.font(size: 24) {
        didSet {
            codeLabel.font = font
            invalidateIntrinsicContentSize()
        }
    }
    
    var codeColor = ColorName.textPrimary.color
    var inactiveColor = ColorName.uiBlueSecondary.color
    var activeColor = ColorName.uiBlue.color
    
    // MARK: - Private properties
    
    private var placeholderString = "–"
    private lazy var width: CGFloat = {
        return (placeholderString as NSString).size(withAttributes: [NSAttributedString.Key.font: font]).width + 10
    }()
    
    // MARK: - Initialization and deinitialization
    
    init() {
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - UIView
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: width, height: font.lineHeight)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return intrinsicContentSize
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        codeLabel.frame = bounds
    }
    
    // MARK: - Internal methods
    
    func apply(state: State) {
        switch state {
        case .active:
            codeLabel.textColor = activeColor
            codeLabel.text = placeholderString
        case .inactive:
            codeLabel.textColor = inactiveColor
            codeLabel.text = placeholderString
        case .filled(let character):
            codeLabel.textColor = codeColor
            codeLabel.text = String(character)
        }
    }
    
    // MARK: - Private methods
    
    private func setupSubviews() {
        addSubview(codeLabel)
        codeLabel.textAlignment = .center
        codeLabel.font = font
        apply(state: .inactive)
        backgroundColor = .clear
    }
    
}

