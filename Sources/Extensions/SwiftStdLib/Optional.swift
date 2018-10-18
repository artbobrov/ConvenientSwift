//
//  Optional.swift
//  BetterSwift
//
//  Created by abobrov on 20/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension Optional {
    /// A Boolean value that determines whether optional hasn't value.
    public var isNil: Bool {
        return self == nil
    }
}

public extension Optional {
    /// Get self of default value (if self is nil).
    ///
    /// - Parameter value: Default value.
    /// - Returns: Self if not nil or default value if nil.
    public func unwrapped(or value: Wrapped) -> Wrapped {
        return self ?? value
    }

    /// Gets the wrapped value of an optional. If the optional is `nil`, throw a custom error.
    ///
    /// - Parameter error: Error to throw if the optional is `nil`.
    /// - Returns: Value wrapped by the optional.
    /// - Throws: Error passed in.
    public func unwrapped(or error: Error) throws -> Wrapped {
        guard let value = self else {
            throw error
        }
        return value
    }

    /// Runs a block to Wrapped if not nil.
    ///
    /// - Parameter block: A block to run if self is not nil.
    public func run(_ block: (Wrapped) -> Void) {
        _ = map(block)
    }
}

infix operator ??=: AssignmentPrecedence
infix operator ?=: AssignmentPrecedence
public extension Optional {
    /// Assign an optional value to a variable only if the value is not nil.
    ///
    /// - Parameters:
    ///   - lhs: Value to assign to.
    ///   - rhs: Autoclosure to assign.
    public static func ??= (lhs: inout Optional, rhs: @autoclosure () -> Optional) {
        guard let rhs = rhs() else { return }
        lhs = rhs
    }

    /// Assign an optional value to a variable only if the variable is nil.
    ///
    /// - Parameters:
    ///   - lhs: Value to assign to.
    ///   - rhs: Autoclosure to assign.
    public static func ?= (lhs: inout Optional, rhs: @autoclosure () -> Optional) {
        if lhs == nil {
            lhs = rhs()
        }
    }
}

public extension Optional where Wrapped: Collection {
    /// A Boolean value that determines whether collection is nil or empty.
    public var isNilOrEmpty: Bool {
        return self == nil || self!.isEmpty
    }
}
