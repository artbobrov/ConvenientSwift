//
//  Bool.swift
//  ConvenientSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension Bool {
    /// Converts boolean value to integer. Returns 1 if true, or 0 if false.
    public var int: Int {
        return self ? 1 : 0
    }

    /// Converts boolean value to string. Returns "true" if true, or "false" if false.
    public var string: String {
        return self ? "true" : "false"
    }
}
