//
//  UIScrollView.swift
//  Unicredit
//
//  Created by Ivan Smetanin on 21/05/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UIScrollView {

    /// Set custom color above table
    func addTopBounceAreaView(color: UIColor = .white) {
        var frame = UIScreen.main.bounds
        frame.origin.y = -frame.size.height

        let view = UIView(frame: frame)
        view.backgroundColor = color

        addSubview(view)
    }

}
