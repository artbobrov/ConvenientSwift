//
//  SignedInteger.swift
//  BetterSwift
//
//  Created by abobrov on 21/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension SignedInteger {
    /// Absolute value of integer number.
    var abs: Self {
        return Swift.abs(self)
    }

    /// A Boolean value that determines whether a number is positive.
    public var isPositive: Bool {
        return self > 0
    }

    /// A Boolean value that determines whether a number is negative.
    public var isNegative: Bool {
        return self < 0
    }

    /// A Boolean value that determines whether a number is even.
    public var isEven: Bool {
        return (self % 2) == 0
    }

    /// A Boolean value that determines whether a number is odd.
    public var isOdd: Bool {
        return !isEven
    }
}

public extension SignedInteger {
    /// Greatest common divisor of integer value and n.
    ///
    /// - Parameter n: Integer value to find gcd with.
    /// - Returns: Greatest common divisor of self and n.
    public func gcd(of n: Self) -> Self {
        return n == 0 ? self : n.gcd(of: self % n)
    }

    /// Least common multiple of integer and n.
    ///
    /// - Parameter n: Integer value to find lcm with.
    /// - Returns: Least common multiple of self and n.
    public func lcm(of n: Self) -> Self {
        return (self * n).abs / gcd(of: n)
    }
}
