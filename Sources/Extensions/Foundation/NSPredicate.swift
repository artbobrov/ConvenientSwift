//
//  NSPredicate.swift
//  ConvenientSwift
//
//  Created by abobrov on 21/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension NSPredicate {
    /// Returns a new predicate formed by NOT-ing the predicate.
    public var not: NSCompoundPredicate {
        return NSCompoundPredicate(notPredicateWithSubpredicate: self)
    }
}

public extension NSPredicate {
    /// Creates a new predicate formed by AND-ing the argument to the predicate.
    ///
    /// - Parameter predicate: Other predicate.
    /// - Returns: NSCompoundPredicate.
    public func and(_ predicate: NSPredicate) -> NSCompoundPredicate {
        return NSCompoundPredicate(andPredicateWithSubpredicates: [self, predicate])
    }

    /// Creates a new predicate formed by OR-ing the argument to the predicate.
    ///
    /// - Parameter predicate: Other predicate.
    /// - Returns: NSCompoundPredicate.
    public func or(_ predicate: NSPredicate) -> NSCompoundPredicate {
        return NSCompoundPredicate(orPredicateWithSubpredicates: [self, predicate])
    }
}

public extension NSPredicate {
    /// Returns a new predicate formed by NOT-ing the predicate.
    ///
    /// - Parameter rhs: NSPredicate to convert.
    /// - Returns: NSCompoundPredicate.
    public static prefix func ! (rhs: NSPredicate) -> NSCompoundPredicate {
        return rhs.not
    }

    /// Returns a new predicate formed by AND-ing the argument to the predicate.
    ///
    /// - Parameters:
    ///   - lhs: NSPredicate.
    ///   - rhs: NSPredicate.
    /// - Returns: NSCompoundPredicate.
    public static func + (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
        return lhs.and(rhs)
    }

    /// Returns a new predicate formed by OR-ing the argument to the predicate.
    ///
    /// - Parameters:
    ///   - lhs: NSPredicate.
    ///   - rhs: NSPredicate.
    /// - Returns: NSCompoundPredicate.
    public static func | (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
        return lhs.or(rhs)
    }

    /// Returns a new predicate formed by remove the argument to the predicate.
    ///
    /// - Parameters:
    ///   - lhs: NSPredicate.
    ///   - rhs: NSPredicate.
    /// - Returns: NSCompoundPredicate.
    public static func - (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
        return lhs + !rhs
    }
}
