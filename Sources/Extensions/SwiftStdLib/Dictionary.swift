//
//  Dictionary.swift
//  ConvenientSwift
//
//  Created by abobrov on 17/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension Dictionary {
    /// Check if key exists in dictionary.
    ///
    /// - Parameter key: Key to search for.
    /// - Returns: True if key exists in dictionary.
    public func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }

    /// Remove all keys contained in the keys parameter from the dictionary.
    ///
    /// - Parameter keys: Keys to be removed.
    public mutating func removeAll<S: Sequence>(keys: S) where S.Element == Key {
        keys.forEach { self.removeValue(forKey: $0) }
    }
}

public extension Dictionary where Key == String {
    /// Lowercase all keys in dictionary.
    public mutating func lowercaseAllKeys() {
        for key in keys {
            let lowercased = key.lowercased()
            guard lowercased != key else { continue }
            self[lowercased] = removeValue(forKey: key)
        }
    }
}

public extension Dictionary where Value: Equatable {
    /// Returns an array of all keys that have the given value in dictionary.
    ///
    /// - Parameter value: Value for which keys are to be fetched.
    /// - Returns: An array containing keys that have the given value.
    public func keys(forValue value: Value) -> [Key] {
        return keys.filter { self[$0] == value }
    }
}

// MARK: Operators

public extension Dictionary {
    /// Merge the keys/values of two dictionaries.
    ///
    /// - Parameters:
    ///   - lhs: Dictionary.
    ///   - rhs: Dictionary.
    /// - Returns: a dictionary with keys and values from both.
    public static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }

    /// Append the keys and values from the second dictionary into the first one.
    ///
    /// - Parameters:
    ///   - lhs: Dictionary to merge to.
    ///   - rhs: Dictionary.
    public static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach { lhs[$0] = $1 }
    }
}
