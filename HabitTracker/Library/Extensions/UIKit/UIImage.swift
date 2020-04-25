//
//  UIImage.swift
//  Unicredit
//
//  Created by Ivan Smetanin on 31/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UIImage {

    /// Creates image with given UIColor. Commonly used for setting UIButton background.
    class func imageWithColor(_ color: UIColor, of size: CGSize = CGSize(width: 1.0, height: 1.0)) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        // need to disable warning here, cause in other way we can't get nonoptional output,
        // and here we guarantee nonnil value.
        // swiftlint:disable force_unwrapping
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        // swiftlint:enable force_unwrapping
        UIGraphicsEndImageContext()
        return image
    }

    /// Resizes image to a provided size
    func resizedTo(size aSize: CGSize) -> UIImage {
        if size.equalTo(aSize) {
            return self
        }

        UIGraphicsBeginImageContextWithOptions(aSize, false, 0.0)
        draw(in: CGRect(x: 0.0, y: 0.0, width: aSize.width, height: aSize.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image ?? self
    }

    /// method that allow image to be tint colored
    ///
    /// - Returns: image, which colored by tint color
    func tintColored() -> UIImage {
        return withRenderingMode(.alwaysTemplate)
    }

}
