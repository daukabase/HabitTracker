//
//  Array.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

extension Array {

    /// Index outside array
    public subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }

    func subArray(range: Range<Int>) -> Array {
        if range.startIndex >= count {
            return []
        }
        return Array(self[range.startIndex..<Swift.min(range.endIndex, count)])
    }
}
