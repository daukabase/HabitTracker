//
//  MessageManager.swift
//  MoveOn
//
//  Created by Daulet on 06/02/2019.
//  Copyright © 2019 daukabase. All rights reserved.
//

import Foundation

class MessageManager {

    public static let shared = MessageManager()

    private var messageQueue = [MessageBanner]()
    private var currentBanner: MessageBanner?

    func showMessage(_ message: String, type: MessageBannerType = .error) {
        let banner = MessageBanner(message: message, type: type)
        banner.delegate = self
        if let currentBanner = currentBanner {
            if banner.messageText != currentBanner.messageText {
                messageQueue.append(banner)
            }
        } else {
            currentBanner = banner
            banner.show()
        }
    }

    func clearMessagesQueue() {
        currentBanner?.closeWithDelay()
        messageQueue.removeAll()
    }
}

extension MessageManager: MessageBannerDelegate {
    func messageDidHide(_ banner: MessageBanner) {
        if let banner = self.messageQueue.popLast() {
            currentBanner = banner
            banner.show()
        } else {
            currentBanner = nil
        }
    }

    func messageDidShow(_ banner: MessageBanner) {}
}
