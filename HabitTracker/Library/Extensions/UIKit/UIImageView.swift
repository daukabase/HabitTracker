//
//  UIImageView.swift
//  Unicredit
//
//  Created by Maxim MAMEDOV on 20/03/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Nuke
import UIKit

extension UIImageView {
    func loadImage(with urlString: String?, placeholderImage: UIImage? = nil, fadeInDuration: TimeInterval = 0.33) {
        let options = ImageLoadingOptions(placeholder: placeholderImage, transition: .fadeIn(duration: 0.33))
        guard let url = URL(string: urlString ?? "") else {
            image = placeholderImage
            return
        }
        Nuke.loadImage(with: url, options: options, into: self)
    }
}
