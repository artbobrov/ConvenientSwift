//
//  Collection.swift
//  ConvenientSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension RandomAccessCollection where Element: Comparable {
    /// Binary search by value.
    ///
    /// - Parameter value: Value to search.
    /// - Returns: index of value (if exists).
    public func binarySearch(by value: Element) -> Index? {
        guard !isEmpty else { return nil }

        if count == 1 {
            return first! == value ? startIndex : nil
        }
        let midIndex = index(startIndex, offsetBy: count / 2)
        if self[midIndex] == value { return midIndex }

        let slicedIndexRange = self[midIndex] < value ? midIndex ..< endIndex : startIndex ..< midIndex

        return self[slicedIndexRange].binarySearch(by: value)
    }
}

public extension Collection {
    /// Performs `each` closure for each element of collection in parallel.
    ///
    /// - Parameter each: Closure to run for each element.
    public func forEachInParallel(_ each: (Element) -> Void) {
        let indicesArray = Array(indices)

        DispatchQueue.concurrentPerform(iterations: indicesArray.count) { index in
            let elementIndex = indicesArray[index]
            each(self[elementIndex])
        }
    }

    ///  Safe protects the array from out of bounds by use of optional.
    ///
    /// - Parameter index: Index of element to access element.
    /// - Returns: Value by index (if index is correct).
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension Collection where Element == IntegerLiteralType, Index == Int {
    /// Returns average of all values in collection.
    public var average: Double {
        return isEmpty ? 0 : Double(reduce(0, +)) / Double(count)
    }
}

public extension Collection where Index == Int {
    /// Get the first index where condition is met.
    ///
    /// - Parameter condition: Condition to evaluate each element against.
    /// - Returns: First index where the specified condition evaluates to true. (optional)
    public func firstIndex(where condition: (Element) throws -> Bool) rethrows -> Index? {
        return try indices.lazy.first { try condition(self[$0]) }
    }

    /// Get the last index where condition is met.
    ///
    /// - Parameter condition: Condition to evaluate each element against.
    /// - Returns: Last index where the specified condition evaluates to true. (optional)
    public func lastIndex(where condition: (Element) throws -> Bool) rethrows -> Index? {
        return try indices.lazy.reversed().first { try condition(self[$0]) }
    }

    ///  Returns an array of slices of length "size" from the array. If array can't be split evenly, the final slice will be the remaining elements.
    ///
    /// - Parameter size: The size of the slices to be returned.
    /// - Returns: grouped self.
    public func group(by size: Int) -> [[Element]]? {
        guard size > 0, !isEmpty else { return nil }
        var value: Int = 0
        var slices: [[Element]] = []
        while value < count {
            slices.append(Array(self[Swift.max(value, startIndex) ..< Swift.min(value + size, endIndex)]))
            value += size
        }
        return slices
    }
}

public extension Collection where Element: Equatable, Index == Int {
    /// First index of a given item in an array.
    ///
    /// - Parameter item: Item to check.
    /// - Returns: First index of item in array (if exists).
    public func firstIndex(of item: Element) -> Index? {
        return firstIndex { $0 == item }
    }

    /// Last index of element in array.
    ///
    /// - Parameter item: Item to check.
    /// - Returns: Last index of item in array (if exists).
    public func lastIndex(of item: Element) -> Index? {
        return lastIndex { $0 == item }
    }
}

public extension Collection where Element: FloatingPoint {
    /// Returns average of all values in collection.
    public var average: Element {
        return isEmpty ? 0 : reduce(0, +) / Element(count)
    }
}
