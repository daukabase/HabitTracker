//
//  NumberConfirmationViewController.swift
//  MoveOn
//
//  Created by Daulet on 11/10/2019.
//  Copyright © 2019 daukabase. All rights reserved.
//

import UIKit

final class NumberConfirmationViewController: UIViewController, ErrorDisplayable, LoaderViewDisplayable {

    private enum Constants {
        static let resendInterval = 60
        static let descriptionLineSpacing: CGFloat = 4
    }
    
    var onSuccess: Closure<String>?
    var onClose: EmptyClosure?
    
    var model = NumberConfirmationViewModel(phoneNumber: "+7 707 898 83 38", timeLeft: Constants.resendInterval)
    
    private var timer: Timer?
    private var timeLeft: Int = Constants.resendInterval
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var resendCodeLabel: UILabel!
    @IBOutlet weak var resendCodeButton: UIButton!
    @IBOutlet weak var inputCodeView: InputCodeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        configureResendTimer(timePeriod: model.timeLeft)
        descriptionLabel.attributedText = model.descriptionAttributed
        setBackButton(style: .orange)
    }
    
}

private extension NumberConfirmationViewController {
    
    @IBAction
    private func resendButtomDidClicked() {
        sendSMS()
    }
    
}
    
private extension NumberConfirmationViewController {
    
    func sendSMS() {
        startLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            self?.endLoading()
            self?.configureResendTimer(timePeriod: Constants.resendInterval)
            self?.inputCodeView.clear()
        }
    }
    
    func commonInit() {
        resendCodeLabel.isHidden = false
        resendCodeButton.isHidden = true
        
        inputCodeView.didFillText = { [weak self] text in
            self?.send(code: text)
        }
        inputCodeView.codeLength = model.codeLength
        inputCodeView.becomeFirstResponder()
        
    }
    
    func configureResendTimer(timePeriod: Int) {
        updateUiContdownChanged()
        timeLeft = timePeriod
        setLabel(timeLeft: timeLeft)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            self?.resendTimerTick(timer: timer)
        }
    }
    
    func resendTimerTick(timer: Timer) {
        descrementTime()
        guard timeLeft == 0 else {
            setLabel(timeLeft: self.timeLeft)
            return
        }
        timer.invalidate()
        updateUiContdownEnded()
    }
    
    private func setLabel(timeLeft: Int) {
        resendCodeLabel.text = "Send SMS again after \(timeLeft) seconds"
    }
    
    private func updateUiContdownChanged() {
        resendCodeLabel.isHidden = false
        resendCodeButton.isHidden = true
    }
    
    private func updateUiContdownEnded() {
        resendCodeLabel.isHidden = true
        resendCodeButton.isHidden = false
    }
    
    private func descrementTime() {
        timeLeft = max(timeLeft - 1, 0)
    }
    
}

private extension NumberConfirmationViewController {
    
    func send(code: String) {
        
    }
    
}
