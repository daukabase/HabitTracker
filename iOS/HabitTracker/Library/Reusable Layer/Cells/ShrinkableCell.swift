//
//  ShrinkableCell.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 11/22/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

class ShrinkableCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        shrink(down: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        shrink(down: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        shrink(down: false)
    }
    
    func shrink(down: Bool) {
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            options: [.allowUserInteraction],
            animations: {
                guard down else {
                    self.transform = .identity
                    return
                }
                self.transform = CGAffineTransform(scaleX: 0.93, y: 0.93)
            },
            completion: nil
        )
    }
    
}
