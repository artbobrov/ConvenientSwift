//
//  Data.swift
//  BetterSwift
//
//  Created by abobrov on 17/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

extension Data {
    /// Return data as an array of bytes.
    public var bytes: [UInt8] {
        return [UInt8](self)
    }
}

extension Data {
    /// String by encoding Data using the given encoding (if applicable).
    ///
    /// - Parameter encoding: String encoding.
    /// - Returns: String by encoding Data using the given encoding (if applicable).
    public func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }
}
