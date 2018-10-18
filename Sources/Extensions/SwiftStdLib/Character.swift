//
//  Character.swift
//  BetterSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension Character {
    /// A Boolean value that determines whether character is a emoji.
    public var isEmoji: Bool {
        let scalar = String(self).unicodeScalars.first!
        switch scalar.value {
        case 0x1F600 ... 0x1F64F, // Emoticons
             0x1F300 ... 0x1F5FF, // Misc Symbols and Pictographs
             0x1F680 ... 0x1F6FF, // Transport and Map
             0x2600 ... 0x26FF, // Misc symbols
             0x2700 ... 0x27BF, // Dingbats
             0xFE00 ... 0xFE0F, // Variation Selectors
             0x1F900 ... 0x1F9FF, // Supplemental Symbols and Pictographs
             0x1F1E6 ... 0x1F1FF: // Flags
            return true
        default:
            return false
        }
    }

    /// A Boolean value that determines whether character is a number.
    public var isNumber: Bool {
        return Int(String(self)) != nil
    }

    /// A Boolean value that determines whether character is a letter.
    public var isLetter: Bool {
        return String(self).rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }

    /// A Boolean value that determines whether character is lowercased.
    public var isLowercased: Bool {
        return String(self) == String(self).lowercased()
    }

    /// A Boolean value that determines whether character is uppercased.
    public var isUppercased: Bool {
        return String(self) == String(self).uppercased()
    }

    /// A Boolean value that determines whether character is a whitespace.
    public var isWhiteSpace: Bool {
        return String(self) == " "
    }
}
