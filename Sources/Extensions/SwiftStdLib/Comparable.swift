//
//  Comparable.swift
//  BetterSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension Comparable {
    /// Checks if value is in the provided range.
    ///
    /// - Parameter range: Range to check.
    /// - Returns: True if value is in range.
    public func `in`(_ range: Range<Self>) -> Bool {
        return range.contains(self)
    }

    /// Checks if value is in the provided range.
    ///
    /// - Parameter range: Closed range to check.
    /// - Returns: True if value is in range.
    public func `in`(_ range: ClosedRange<Self>) -> Bool {
        return range.contains(self)
    }

    /// Returns value limited within the provided range.
    ///
    /// - Parameter range: Range to limit.
    /// - Returns: A value limited to the range between `min` and `max`.
    public func clamped(to range: ClosedRange<Self>) -> Self {
        return max(range.lowerBound, min(self, range.upperBound))
    }
}
