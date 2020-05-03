//
//  Maskable.swift
//  MoveOn
//
//  Created by Daulet on 11/29/19.
//  Copyright © 2019 daukabase. All rights reserved.
//

import Foundation

protocol Maskable {
    func getMasked(from value: String) -> String
    func mask(_ value: String) -> String
}
 
extension Maskable {
    
    private var defaultPhoneNumber: String {
        return "+X (XXX) XXX XX XX"
    }
    
    private var replacementCharacter: Character {
        return "X"
    }
    
    func getMasked(from value: String) -> String {
        let cleanPhoneNumber = value.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let maskedValue = mask(cleanPhoneNumber)

        return maskedValue
    }

    func mask(_ value: String) -> String {
        let mask = defaultPhoneNumber
        
        var result = ""
        var index = value.startIndex

        for character in mask where index < value.endIndex {
            if character == replacementCharacter {
                result.append(value[index])
                index = value.index(after: index)
            } else {
                result.append(character)
            }
        }

        return result
    }
}
