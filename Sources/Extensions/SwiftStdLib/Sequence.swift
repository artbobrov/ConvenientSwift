//
//  Sequence.swift
//  ConvenientSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension Sequence {
    #if swift(>=4.2)
    #else
        /// Check if all elements in collection match a conditon.
        ///
        /// - Parameter condition: Condition to evaluate each element against.
        /// - Returns: True when all elements in the array match the specified condition.
        public func all(matching condition: (Element) throws -> Bool) rethrows -> Bool {
            return try !contains { try !condition($0) }
        }
    #endif

    /// Check if no elements in collection match a conditon.
    ///
    /// - Parameter condition: Condition to evaluate each element against.
    /// - Returns: True when no elements in the array match the specified condition.
    public func none(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try condition($0) }
    }

    /// Check if any element in collection match a conditon.
    ///
    /// - Parameter condition: Condition to evaluate each element against.
    /// - Returns: True when no elements in the array match the specified condition.
    public func any(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try contains { try condition($0) }
    }

    /// Get last element that satisfies a conditon.
    ///
    /// - Parameter condition: Condition to evaluate each element against.
    /// - Returns: The last element in the array matching the specified condition. (optional)
    public func last(where condition: (Element) throws -> Bool) rethrows -> Element? {
        for element in reversed() {
            if try condition(element) { return element }
        }
        return nil
    }

    /// Filter elements based on a rejection condition.
    ///
    /// - Parameter condition: To evaluate the exclusion of an element from the array.
    /// - Returns: The array with rejected values filtered from it.
    public func reject(where condition: (Element) throws -> Bool) rethrows -> [Element] {
        return try filter { try !condition($0) }
    }

    #if swift(>=5.0)
    #else
        /// Get element count based on condition.
        ///
        /// - Parameter condition: Condition to evaluate each element against.
        /// - Returns: Number of times the condition evaluated to true.
        public func count(where condition: (Element) throws -> Bool) rethrows -> Int {
            var count = 0
            for element in self where try condition(element) {
                count += 1
            }
            return count
        }
    #endif

    /// Calls the given closure with each element where condition is true.
    ///
    /// - Parameters:
    ///   - condition: Condition to evaluate each element against.
    ///   - body: A closure that takes an element of the array as a parameter.
    public func forEach(where condition: (Element) throws -> Bool, body: (Element) throws -> Void) rethrows {
        for element in self where try condition(element) {
            try body(element)
        }
    }

    /// Reduces an array while returning each interim combination.
    ///
    /// - Parameters:
    ///   - initial: Reduces an array while returning each interim combination.
    ///   - next: Closure that combines the accumulating value and next element of the array.
    /// - Returns: An array of the final accumulated value and each interim combination.
    public func accumulate<U>(initial: U, next: (U, Element) throws -> U) rethrows -> [U] {
        var runningTotal = initial
        return try map { element in
            runningTotal = try next(runningTotal, element)
            return runningTotal
        }
    }

    /// Reduces an array while returning each interim combination.
    ///
    /// - Parameters:
    ///   - predicate: Condition of inclusion to evaluate each element against.
    ///   - transform: Transform element function to evaluate every element.
    /// - Returns: an filtered and mapped array.
    public func filtered<T>(_ predicate: (Element) throws -> Bool, map transform: (Element) throws -> T) rethrows -> [T] {
        return try compactMap {
            if try predicate($0) {
                return try transform($0)
            }
            return nil
        }
    }

    /// Get the only element based on a condition.
    ///
    /// - Parameter condition: Condition to evaluate each element against.
    /// - Returns: The only element in the array matching the specified condition. If there are more matching elements, nil is returned. (optional)
    public func single(where condition: ((Element) throws -> Bool)) rethrows -> Element? {
        var singleElement: Element?
        for element in self where try condition(element) {
            guard singleElement == nil else {
                singleElement = nil
                break
            }
            singleElement = element
        }
        return singleElement
    }

    /// Creates dictionary from collection.
    ///
    /// - Parameter transform: Closure that transforms element into key-value pair.
    /// - Returns: Dictionary.
    public func dictionary<Key: Hashable, Value>(_ transform: (Element) -> (key: Key, value: Value)) -> [Key: Value] {
        return reduce(into: [:], { dictionary, element in
            let pair = transform(element)
            dictionary[pair.key] = pair.value
        })
    }

	/// Returns an array containing the results of mapping the given keyPath value over the sequence’s elements.
	///
	///		let names = persons.map(at: \.name)
	///
	/// - Parameter keyPath: Given keyPath.
	/// - Returns: An array containing the transformed elements of this sequence.
	public func map<Value>(at keyPath: KeyPath<Element, Value>) -> [Value] {
		return map { $0[keyPath: keyPath] }
	}
}

public extension Sequence where Element: Equatable {
    /// Check if array contains an array of elements.
    ///
    /// - Parameter elements: Rlements to check.
    /// - Returns: True if array contains all given items.
    public func contains(_ elements: Element...) -> Bool {
        return contains(elements)
    }

    /// Check if array contains an array of elements.
    ///
    /// - Parameter elements: An array of elements to check.
    /// - Returns: True if array contains all given items.
    public func contains(_ elements: [Element]) -> Bool {
        guard !elements.isEmpty else { return true }

        for element in elements {
            if !contains(element) {
                return false
            }
        }
        return true
    }
}

public extension Sequence where Element: Hashable {
    /// Check whether a sequence contains duplicates.
    public var hasDuplicates: Bool {
        var set = Set<Element>()
        for element in self {
            if !set.insert(element).inserted {
                return true
            }
        }
        return false
    }
}

public extension Sequence where Element: Numeric {
    /// Sum of all elements in array.
    ///
    /// - Returns: Sum of the array's elements.
    public func sum() -> Element {
        return reduce(0, +)
    }
}
