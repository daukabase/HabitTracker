//
//  UIImage.swift
//  Unicredit
//
//  Created by Ivan Smetanin on 31/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UIImage {

    func filled(with _color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        _color.setFill()

        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    class func circle(diameter: CGFloat, borderColor: UIColor) -> UIImage {
        let diameter = diameter
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: diameter, height: diameter))
        
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            ctx.cgContext.setStrokeColor(borderColor.cgColor)
            
            ctx.cgContext.setLineWidth(1)

            let rectangle = CGRect(x: 1, y: 1, width: diameter - 2, height: diameter - 2)
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .stroke)
        }

        return img
    }
    
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
