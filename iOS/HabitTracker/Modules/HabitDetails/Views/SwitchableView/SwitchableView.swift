
//
//  SwitchableView.swift
//  HabitTracker
//
//  Created by Daulet on 4/26/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import SnapKit

final class SwitchableView: UIView {
    
    var onStateChanged: BoolClosure?
    
    var isOn: Bool {
        return switchView.isOn
    }
    
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.font = FontFamily.Gilroy.regular.font(size: 16)
        label.textColor = ColorName.uiOrange.color
        
        return label
    }()
    
    lazy var switchView: UISwitch = {
        let switchView = UISwitch()
        
        switchView.apply(style: .default)
        
        return switchView
    }()
    
    lazy var lineView: UIView = {
        let view = UIView(frame: .zero)
        
        view.backgroundColor = ColorName.uiBlueSecondary.color
        
        return view
    }()
    
    lazy var loaderView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func commonInit() {
        [label, switchView, loaderView, lineView].forEach(addSubview)
        
        switchView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-17)
        }
        
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalTo(switchView.snp.left).offset(-8)
            make.centerY.equalTo(switchView)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        loaderView.snp.makeConstraints { make in
            make.center.equalTo(switchView)
        }
        
        switchView.addTarget(self, action: #selector(setState(_:)), for: .valueChanged)
    }
    
    
    func set(isOn: Bool) {
        switchView.setOn(isOn, animated: true)
    }
    
    func startLoading() {
        loaderView.startAnimating()
        
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.switchView.alpha = 0
        }, completion: { [weak self] _ in
            self?.switchView.isHidden = true
        })
    }
    
    func endLoading() {
        loaderView.stopAnimating()
        
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.switchView.alpha = 1
        }, completion: { [weak self] _ in
            self?.switchView.isHidden = false
        })
        switchView.isHidden = false
    }
    
    @objc
    private func setState(_ switchView: UISwitch) {
        onStateChanged?(switchView.isOn)
    }
    
}
