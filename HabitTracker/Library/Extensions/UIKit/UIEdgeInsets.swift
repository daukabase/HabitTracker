//
//  UIeInset.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 27/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UIEdgeInsets {

    var vertical: CGFloat {
        return top + bottom
    }

    var horisontal: CGFloat {
        return left + right
    }

}
