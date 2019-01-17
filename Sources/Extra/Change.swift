//
//  Change.swift
//  ConvenientSwift
//
//  Created by Artem Bobrov on 17/01/2019.
//

import Foundation

public protocol Change {}

extension Change {
	/// Sets self a value for keypath.
	///
	///		someAction(value.change(key: \.name, with: "Tom"))
	///
	/// - Parameters:
	///   - key: Key path to change.
	///   - value: New value.
	/// - Returns: Transformed self instance.
	public func change<T>(key: WritableKeyPath<Self, T>, with value: T) -> Self {
		var copy = self
		copy[keyPath: key] = value
		return copy
	}
}

//extension Change where Self: AnyObject {
//	/// Sets self a value for keypath.
//	///
//	///
//	///
//	/// - Parameters:
//	///   - key: Key path to change.
//	///   - value: New value.
//	/// - Returns: Transformed self instance.
//	public func change<T>(key: WritableKeyPath<Self, T>, with value: T) -> Self {
//		var copy = self
//		copy[keyPath: key] = value
//		return copy
//	}
//}


extension NSObject: Change {}
