//
//  TermsOfUseView.swift
//  Business
//
//  Created by Nurkhat Pazylov on 4/17/20.
//  Copyright © 2020 AO Alfa-Bank. All rights reserved.
//

import SwiftEntryKit

final class TermsOfUseView: UIView {
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.attributedText = Typography.titleFourth(string: title, color: ColorName.textPrimary.color, aligment: .center).styledText
        label.textAlignment = .center
        return label
    }()
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTappedClose(_:)), for: .touchUpInside)
        button.contentMode = .center
        button.tintColor = ColorName.textPrimary.color
        button.setImage(Asset.alertCloseIcon.image, for: .normal)
        return button
    }()
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Typography.subhead(string: body, color: ColorName.textSecondary.color, aligment: .center).styledText
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    // MARK: - Properties
    let title: String
    let body: String

    // MARK: - Methods
    @objc private func didTappedClose(_ sender: UIButton) {
        SwiftEntryKit.dismiss(.all)
    }
    
    private func configureViews() {
        clipsToBounds = true
        layer.cornerRadius = 8
        backgroundColor = ColorName.uiWhite.color
        [titleLabel, closeButton, bodyLabel].forEach { addSubview($0) }
        makeConstraints()
    }

    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(36)
            make.trailing.equalToSuperview().inset(36)
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.trailing.equalToSuperview().inset(18)
            make.size.equalTo(CGSize(width: 18, height: 18))
        }
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(24)
        }
    }

    // MARK: - Inits
    init(title: String, body: String) {
        self.title = title
        self.body = body
        
        super.init(frame: .zero)
        
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
