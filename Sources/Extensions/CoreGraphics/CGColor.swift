//
//  CGColor.swift
//  BetterSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension CGColor {
    /// Create UIColor instance from CGColor.
    public var uiColor: UIColor {
        return UIColor(cgColor: self)
    }
}
