//
//  Never.swift
//  ConvenientSwift
//
//  Created by Artem Bobrov on 14.09.2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

/// Nil-coalescing operator that fails when value is nil.
///
/// 	let value = optionalValue ?? fatalError("optionalValue is nil") // fails if optional value is nil.
///
/// - Parameters:
///   - lhs: Optional value.
///   - rhs: Expression that returns Never.
/// - Returns: non-optional value.
public func ?? <T>(lhs: T?, rhs: @autoclosure () -> Never) -> T {
    if let value = lhs {
        return value
    }

    rhs()
}
