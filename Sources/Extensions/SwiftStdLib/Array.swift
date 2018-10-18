//
//  Array.swift
//  ConvenientSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension Array {
    /// Insert an element at the beginning of array.
    ///
    /// - Parameter newElement: Element to insert.
    public mutating func prepend(_ newElement: Element) {
        insert(newElement, at: 0)
    }

    /// Safely Swap values at index positions.
    ///
    /// - Parameters:
    ///   - index: Index of first element.
    ///   - otherIndex: Index of other element.
    public mutating func safeSwap(from index: Index, to otherIndex: Index) {
        guard index != otherIndex,
            startIndex ..< endIndex ~= index,
            startIndex ..< endIndex ~= otherIndex else { return }
        swapAt(index, otherIndex)
    }

    /// Keep elements of Array while condition is true.
    ///
    /// - Parameter condition: Condition to evaluate each element against.
    /// - Returns: Self after applying provided condition.
    /// - Throws: Provided condition exception.
    @discardableResult
    public mutating func keep(while condition: (Element) throws -> Bool) rethrows -> [Element] {
        for (index, element) in lazy .enumerated() where try !condition(element) {
            self = Array(self[startIndex ..< index])
            break
        }
        return self
    }

    /// Take element of Array while condition is true.
    ///
    /// - Parameter condition: Condition to evaluate each element against.
    /// - Returns: All elements up until condition evaluates to false.
    public func take(while condition: (Element) throws -> Bool) rethrows -> [Element] {
        for (index, element) in lazy .enumerated() where try !condition(element) {
            return Array(self[startIndex ..< index])
        }
        return self
    }

    /// Skip elements of Array while condition is true.
    ///
    /// - Parameter condition: Condition to evaluate each element against.
    /// - Returns: All elements after the condition evaluates to false.
    public func skip(while condition: (Element) throws -> Bool) rethrows -> [Element] {
        for (index, element) in lazy .enumerated() where try !condition(element) {
            return Array(self[index ..< endIndex])
        }
        return [Element]()
    }

    /// Separates an array into 2 arrays based on a predicate.
    ///
    /// - Parameter predicate: Condition to evaluate each element against.
    /// - Returns: Two arrays, the first containing the elements for which the specified condition evaluates to true, the second containing the rest.
    public func divided(by predicate: (Element) throws -> Bool) rethrows -> ([Element], [Element]) {
        return try reduce(into: ([], []), { result, element in
            if try predicate(element) {
                result.0.append(element)
			} else {
				result.1.append(element)
			}
        })
    }

    /// Returns a sorted array based on an optional keypath.
    ///
    /// - Parameter path: Key path to sort. The key path type must be Comparable.
    /// - Parameter ascending: If order must be ascending.
    /// - Returns: Sorted array based on keyPath.
    public func sorted<T: Comparable>(by path: KeyPath<Element, T?>, ascending: Bool = true) -> [Element] {
        return sorted(by: { (lhs, rhs) -> Bool in
            guard let lhsValue = lhs[keyPath: path], let rhsValue = rhs[keyPath: path] else { return false }
            return ascending ? lhsValue < rhsValue : lhsValue > rhsValue
        })
    }

    /// Returns a sorted array based on a keypath.
    ///
    /// - Parameter path: Key path to sort. The key path type must be Comparable.
    /// - Parameter ascending: If order must be ascending.
    /// - Returns: Sorted array based on keyPath.
    public func sorted<T: Comparable>(by path: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        return sorted(by: { (lhs, rhs) -> Bool in
            ascending ? lhs[keyPath: path] < rhs[keyPath : path]: lhs[keyPath: path] > rhs[keyPath: path]
        })
    }

    /// Sort the array based on an optional keypath.
    ///
    /// - Parameters:
    ///   - path: Key path to sort, must be Comparable.
    ///   - ascending: Whether order is ascending or not.
    /// - Returns: self after sorting.
    public mutating func sort<T: Comparable>(by path: KeyPath<Element, T?>, ascending: Bool = true) {
        self = sorted(by: path, ascending: ascending)
    }

    /// Sort the array based on a keypath.
    ///
    /// - Parameters:
    ///   - path: Key path to sort, must be Comparable.
    ///   - ascending: Whether order is ascending or not.
    public mutating func sort<T: Comparable>(by path: KeyPath<Element, T>, ascending: Bool = true) {
        self = sorted(by: path, ascending: ascending)
    }
}

public extension Array where Element: Equatable {
    /// Remove all instances of an item from array.
    ///
    /// - Parameter item: Item to remove.
    /// - Returns: Self after removing all instances of item.
    @discardableResult
    public mutating func removeAll(_ item: Element) -> [Element] {
        removeAll(where: { $0 == item })
        return self
    }

    /// Remove all instances contained in items parameter from array.
    ///
    /// - Parameter items: Items to remove.
    /// - Returns: Self after removing all instances of all items in given array.
    @discardableResult
    public mutating func removeAll(_ items: [Element]) -> [Element] {
        guard !items.isEmpty else { return self }
        removeAll(where: { items.contains($0) })
        return self
    }

    /// Remove all duplicate elements from Array.
    public mutating func removeDuplicates() {
        self = withoutDuplicates()
    }

    /// Return array with all duplicate elements removed.
    ///
    /// - Returns: An array of unique elements.
    public func withoutDuplicates() -> [Element] {
        return reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
}
