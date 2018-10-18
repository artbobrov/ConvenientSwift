//
//  Then.swift
//  BetterSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public protocol Then {}

public extension Then where Self: Any {
    /// Transforms self with closure.
    ///
    /// 	point.with {
    /// 		$0.x = 5
    /// 		$0.y = 5
    /// 	}
    ///
    /// - Parameter block: Closure containing tranformations.
    /// - Returns: Transformed self instance.
    public func with(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }

    /// Does some actions with self instance.
    ///
    /// 	point.do {
    /// 		$0.x = 5
    /// 		$0.y = 5
    /// 	}
    ///
    /// - Parameter block: Closure with actions.
    public func `do`(_ block: (Self) throws -> Void) rethrows {
        try block(self)
    }
}

extension Then where Self: AnyObject {
    /// Transforms self with closure.
    ///
    /// 	let view = UIView().then {
    /// 		$0.frame = .zero
    /// 		$0.layer.cornerRadius = 5
    /// 	}
    ///
    /// - Parameter block: Closure containing tranformations.
    /// - Returns: Transformed self instance.
    public func then(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

extension NSObject: Then {}

extension CGPoint: Then {}
extension CGRect: Then {}
extension CGSize: Then {}
extension CGVector: Then {}

extension UIEdgeInsets: Then {}
extension UIOffset: Then {}
extension UIRectEdge: Then {}
