//
//  UserDefaults.swift
//  ConvenientSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension UserDefaults {
    /// Get RawRepresentable value by given key from UserDefaults by using subscript.
    ///
    /// - Parameter key: Given key.
    public subscript<T: RawRepresentable>(key: String) -> T? {
        get {
            if let rawValue = value(forKey: key) as? T.RawValue {
                return T(rawValue: rawValue)
            }
            return nil
        }
        set {
            set(newValue?.rawValue, forKey: key)
        }
    }

    /// Get url value by given key from UserDefaults by using subscript.
    ///
    /// - Parameter key: Given key.
    public subscript(key: String) -> URL? {
        get {
            return url(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }

    /// Get object value by given key from UserDefaults by using subscript.
    ///
    /// - Parameter key: Given key.
    /// - Returns: Object for key (if exists).
    public subscript(key: String) -> Any? {
        get {
            return object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }

    /// Get boolean value by given key from UserDefaults by using subscript.
    ///
    /// - Parameter key: Given key.
    /// - Returns: Boolean object for key (if exists).
    public subscript(key: String) -> Bool? {
        get {
            return bool(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }

    /// Get Double value by given key from UserDefaults by using subscript.
    ///
    /// - Parameter key: Given key.
    /// - Returns: Double object for key (if exists).
    public subscript(key: String) -> Double? {
        get {
            return double(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }

    /// Get Float value by given key from UserDefaults by using subscript.
    ///
    /// - Parameter key: Given key.
    /// - Returns: Float object for key (if exists).
    public subscript(key: String) -> Float? {
        get {
            return float(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }

    /// Get integer value by given key from UserDefaults by using subscript.
    ///
    /// - Parameter key: Given key.
    /// - Returns: Integer object for key (if exists).
    public subscript(key: String) -> Int? {
        get {
            return integer(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }
}

extension UserDefaults {
    /// Retrieves a Decodable object from UserDefaults.
    ///
    /// - Parameters:
    ///   - type: Type to retrieve.
    ///   - key: Identifier of the object.
    ///   - decoder: Custom JSONDecoder instance. Defaults to `JSONDecoder()`.
    /// - Returns: Decodable object for key (if exists).
    public func object<T: Decodable>(_ type: T.Type, with key: String, using decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }

    /// Allows storing of Encodable objects to UserDefaults.
    ///
    /// - Parameters:
    ///   - object: Encodable object to store.
    ///   - key: Identifier of the object.
    ///   - encoder: Custom JSONEncoder instance. Defaults to `JSONEncoder()`.
    public func set<T: Encodable>(object: T, forKey key: String, using encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        set(data, forKey: key)
    }
}
