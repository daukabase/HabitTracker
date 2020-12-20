//
//  FilterView.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 12/21/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

class FilterView: UIView {
    
    var selectedSegmentIndex: Int {
        return stackView
            .arrangedSubviews
            .compactMap { $0 as? FilterSegmentView }
            .firstIndex(where: { $0.state == .selected }) ?? 0
    }
    
    var onChange: EmptyClosure?
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.spacing = 12
        
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(segments: [FilterSegmentViewModel]) {
        stackView.removeAllArrangedSubviews()
        
        segments.forEach { model in
            let view = FilterSegmentView()
            view.title = model.title
            view.set(selected: model.isSelected)
            view.onSelect = { [weak self] in
                self?.set(selectedView: view)
            }
            
            stackView.addArrangedSubview(view)
        }
    }
    
    private func set(selectedView: FilterSegmentView) {
        guard let selectedIndex = stackView.arrangedSubviews.firstIndex(where: { $0 === selectedView }) else {
            return
        }
        
        stackView.arrangedSubviews.enumerated().forEach { (index, view) in
            guard let segment = view as? FilterSegmentView else {
                return
            }
            segment.set(selected: index == selectedIndex)
        }
        onChange?()
    }
    
}

struct FilterSegmentViewModel {
    
    var title: String
    var isSelected: Bool
    
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
    
}

class FilterSegmentView: UIView {
    
    enum SegmentState: CaseIterable {
        case selected
        case notSelected
        
        var font: Font {
            switch self {
            case .selected:
                return FontFamily.Gilroy.semibold.font(size: 12)
            case .notSelected:
                return FontFamily.Gilroy.medium.font(size: 12)
            }
        }
        
        var color: UIColor {
            switch self{
            case .selected:
                return ColorName.uiBlue.color
            case .notSelected:
                return ColorName.uiGraySecondary.color
            }
        }
        
        var backgroundColor: UIColor {
            switch self{
            case .selected:
                return ColorName.uiBlue.color.withAlphaComponent(0.1)
            case .notSelected:
                return ColorName.uiWhite.color
            }
        }
    
        func applyShadow(to view: UIView) {
            switch self{
            case .selected:
                view.applyDropShadow(color: color, opacity: 0.1, offset: CGSize(width: 0, height: 1), radius: 4, scale: true)
            case .notSelected:
                view.applyDropShadow(color: UIColor.black, opacity: 0.1, offset: CGSize(width: 0, height: 1), radius: 5, scale: true)
            }
        }
    }
    
    var state: SegmentState = .selected {
        didSet {
            updateState()
        }
    }
    
    var title: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }
    
    var onSelect: EmptyClosure?
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        return label
    }()
    
    private lazy var containerView = UIView(frame: .zero)
    
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
    
    init() {
        super.init(frame: .zero)
        
        [containerView].forEach(addSubview)
        containerView.addSubview(label)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(1)
        }
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        snp.makeConstraints { make in
            make.height.equalTo(28)
        }
        addGestureRecognizer(tapGesture)
        
        containerView.masksToBounds = false
        containerView.cornerRadius = 13
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(selected: Bool) {
        state = selected ? .selected : .notSelected
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        state.applyShadow(to: self)
    }
    
    private func updateState() {
        label.font = state.font
        label.textColor = state.color
        containerView.backgroundColor = state.backgroundColor
        containerView.layer.borderColor = state.color.cgColor
        containerView.layer.borderWidth = state == .selected ? 1 : 0
    }
    
    @objc
    private func onTap() {
        onSelect?()
    }
    
}
