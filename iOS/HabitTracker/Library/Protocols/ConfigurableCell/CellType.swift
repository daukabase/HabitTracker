//
//  CellType.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 12/20/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

enum CellType: CaseIterable {
    case habitActionable
    case habitInfo
}

extension CellType {
    
    var type: UITableViewCell.Type {
        switch self {
        case .habitActionable:
            return HabitCell.self
        case .habitInfo:
            return HabitDisplayCell.self
        }
    }
    
}
