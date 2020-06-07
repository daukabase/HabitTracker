//
//  ActionableLabel.swift
//  Unicredit
//
//  Created by Alexander Filimonov on 30/07/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

final class ActionableLabel: UILabel {
    
    // MARK: - Nested types
    
    typealias TextAction = () -> ()
    
    typealias Part = (
        text: String,
        attributes: [StringAttribute],
        isHighlighted: Bool,
        action: TextAction?
    )
    
    private enum Constants {
        static let highlightedAlpha: CGFloat = 0.5
        static let defaultForegroundColor = ColorName.textPrimary.color
        static let defaultAttributes: [StringAttribute] = [
            .font(FontFamily.Gilroy.regular.font(size: 12)),
            .aligment(.center),
            .lineSpacing(0),
            .foregroundColor(Constants.defaultForegroundColor)
        ]
    }
    
    // MARK: - Internal properties
    
    var globalAttributes: [StringAttribute] = Constants.defaultAttributes {
        didSet {
            builder = StringBuilder(attributes: globalAttributes)
            reload()
        }
    }
    
    // MARK: - Private properties
    
    private var parts: [Part] = []
    
    private var heightCorrection: CGFloat = 0
    
    private lazy var textStorage = NSTextStorage()
    private lazy var layoutManager = NSLayoutManager()
    private lazy var textContainer = NSTextContainer()
    
    private lazy var builder = StringBuilder(attributes: globalAttributes)
    
    // MARK: - UILabel properties
    
    override var numberOfLines: Int {
        didSet { textContainer.maximumNumberOfLines = numberOfLines }
    }
    
    override var lineBreakMode: NSLineBreakMode {
        didSet { textContainer.lineBreakMode = lineBreakMode }
    }
    
    // MARK: - Initialization and deinitialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - UILabel properties
    
    override func drawText(in rect: CGRect) {
        let range = NSRange(location: 0, length: textStorage.length)
        
        textContainer.size = rect.size
        let newOrigin = textOrigin(inRect: rect)
        
        layoutManager.drawBackground(forGlyphRange: range, at: newOrigin)
        layoutManager.drawGlyphs(forGlyphRange: range, at: newOrigin)
    }
    
    // MARK: - Auto layout
    
    override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        textContainer.size = CGSize(width: superSize.width, height: CGFloat.greatestFiniteMagnitude)
        let size = layoutManager.usedRect(for: textContainer)
        return CGSize(width: ceil(size.width), height: ceil(size.height + heightCorrection))
    }
    
    // MARK: - Internal methods
    
    func clear() {
        parts.removeAll()
        text = nil
        attributedText = nil
    }
    
    func append(text: String, attributes: [StringAttribute] = [], action: TextAction? = nil) {
        parts.append((text: text, attributes: attributes, isHighlighted: false, action: action))
        reload()
    }
    
    func setHighlighted(at index: Int) {
        parts[index].isHighlighted = true
        reload()
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = lineBreakMode
        isUserInteractionEnabled = true
    }
    
    private func textOrigin(inRect rect: CGRect) -> CGPoint {
        let usedRect = layoutManager.usedRect(for: textContainer)
        heightCorrection = (rect.height - usedRect.height) / 2
        let glyphOriginY = heightCorrection > 0 ? rect.origin.y + heightCorrection : rect.origin.y
        return CGPoint(x: rect.origin.x, y: glyphOriginY)
    }
    
    private func unhighlightAllParts() {
        parts.enumerated().forEach { curIndex, _ in
            parts[curIndex].isHighlighted = false
        }
        reload()
    }
    
    private func reload() {
        builder.clear()
        
        for part in parts {
            var currenAttributes: [StringAttribute] = part.attributes
            
            if let foregroundColor = part.attributes.foregroundColor {
                let color = part.isHighlighted
                    ? foregroundColor.withAlphaComponent(Constants.highlightedAlpha)
                    : foregroundColor
                currenAttributes.append(.foregroundColor(color))
            }
            builder.add(text: part.text, with: currenAttributes)
        }
        let attributedString = builder.value
        
        attributedText = attributedString
        textStorage.setAttributedString(attributedString)
        
        setNeedsDisplay()
    }
    
    /// Method for detecting is part tapped
    ///
    /// - Parameters:
    ///   - part: some part of label
    ///   - location: location of tap
    /// - Returns: is this part located on passed location
    private func isPart(_ part: Part, locatedAt location: CGPoint) -> Bool {
        guard textStorage.length > 0, let text = self.text else {
            return false
        }
        
        var correctLocation = location
        correctLocation.y -= heightCorrection
        let boundingRect = layoutManager.boundingRect(forGlyphRange: NSRange(location: 0, length: textStorage.length),
                                                      in: textContainer)
        guard boundingRect.contains(correctLocation) else {
            return false
        }
        
        let index = layoutManager.glyphIndex(for: correctLocation, in: textContainer)
        
        let range = (text as NSString).range(of: part.text)
        return index >= range.location && index <= range.location + range.length
    }
    
}

// MARK: - Handle UI Responder touches

extension ActionableLabel {
    
    /// Method for handling touch
    ///
    /// - Parameter touch: UITouch object
    /// - Returns: should we avoid super method call
    private func onTouch(_ touch: UITouch) -> Bool {
        let location = touch.location(in: self)
        
        let filteredParts = parts.enumerated().filter {
            return $0.element.action != nil
                && isPart($0.element, locatedAt: location)
                && bounds.contains(location)
        }
        
        switch touch.phase {
        case .began:
            filteredParts.forEach {
                setHighlighted(at: $0.offset)
            }
        case .ended:
            unhighlightAllParts()
            filteredParts.forEach {
                $0.element.action?()
            }
        case .cancelled:
            unhighlightAllParts()
            return false
        default:
            return false
        }
        
        return !filteredParts.isEmpty
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        if onTouch(touch) {
            return
        }
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        if onTouch(touch) {
            return
        }
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        _ = onTouch(touch)
        super.touchesCancelled(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        if onTouch(touch) {
            return
        }
        super.touchesEnded(touches, with: event)
    }
    
}


fileprivate extension Array where Element == StringAttribute {
    var foregroundColor: UIColor? {
        for attribute in self {
            if case .foregroundColor(let foregroundColor) = attribute {
                return foregroundColor
            }
        }
        return nil
    }
}
