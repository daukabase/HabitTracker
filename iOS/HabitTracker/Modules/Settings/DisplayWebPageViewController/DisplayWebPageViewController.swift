//
//  DisplayWebPageViewController.swift
//
//  Copyright © 2019 readless LLC. All rights reserved.
//

import UIKit
import WebKit
import PinLayout

enum DisplayWebContentType {
    case terms
    case privacy
    case other(URL?)
}

fileprivate extension DisplayWebContentType {
    var url: URL? {
        switch self {
        case .terms:
            return URL(string: "https://daukabase.github.io/terms.html")
        case .privacy:
            return URL(string: "https://daukabase.github.io/privacypolicy.html")
        case .other(let url):
            return url
        }
    }
}

class DisplayWebPageViewController: UIViewController, WKNavigationDelegate {
    
    var content: DisplayWebContentType? {
        didSet {
            if isViewLoaded {
                loadData()
            }
        }
    }
    
    lazy var webView = WKWebView(frame: .zero)
    
    lazy var closeButton: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(closeButtonDidClicked), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(Asset.deleteButton.image, for: .normal)
        btn.clipsToBounds = true
        btn.applyDropShadow()
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        commonInit()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.frame = CGRect(
            x: 13,
            y: view.safeAreaInsets.top + 13,
            width: 28,
            height: 28)
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
        
        webView.pin.all().marginTop(view.safeAreaInsets.top)
    }
    
    @objc
    private func closeButtonDidClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    private func loadData() {
        guard let _url = content?.url, let url = getValidUrl(from: _url) else {
            return
        }
    
        webView.load(URLRequest(url: url))
    }
    
    private func getValidUrl(from url: URL) -> URL? {
        guard url.absoluteString.hasPrefix("http://") || url.absoluteString.hasPrefix("https://") else {
            return URL(string: "http://" + url.absoluteString)
        }
        
        return url
    }
    
    private func commonInit() {
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self

        view.addSubview(webView)
        view.addSubview(closeButton)
    }
    
}
