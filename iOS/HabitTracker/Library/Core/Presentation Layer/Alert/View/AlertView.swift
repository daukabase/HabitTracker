//
//  AlertView.swift
//  Business
//
//  Created by Nurkhat Pazylov on 10/29/19.
//  Copyright © 2019 AO Alfa-Bank. All rights reserved.
//

import SwiftEntryKit

class AlertView: UIView {

    // MARK: - Enum
    enum ViewType {
        case noInternet
        case error
        case success
    }

    // MARK: - Views
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = FontFamily.SFProDisplay.regular.font(size: 13)
        return label
    }()

    // MARK: - Properties
    let type: ViewType

    // MARK: - Methods
    private func configureViews() {
        [messageLabel].forEach { addSubview($0) }
        makeConstraints()
    }

    private func makeConstraints() {
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.greaterThanOrEqualTo(32)
        }
    }

    // MARK: - Inits
    init(type: ViewType) {
        self.type = type
        super.init(frame: .zero)
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with message: String? = nil) {
        switch type {
        case .success:
            messageLabel.text = message
            backgroundColor = ColorName.uiGreenSuccess.color
            messageLabel.textColor = ColorName.uiWhite.color
        case .error:
            messageLabel.text = message
            backgroundColor = ColorName.uiRed.color
            messageLabel.textColor = ColorName.uiWhite.color
        case .noInternet:
            messageLabel.text = L10n.Common.Error.Network.NoInternet.message
            backgroundColor = ColorName.uiRed.color
            messageLabel.textColor = ColorName.uiWhite.color
        }
    }
    
}
