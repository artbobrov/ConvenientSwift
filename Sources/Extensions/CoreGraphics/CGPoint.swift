//
//  CGPoint.swift
//  BetterSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension CGPoint {
    /// Calculates distance between two points.
    ///
    /// - Parameters:
    ///   - point: Firts point.
    ///   - destination: Second point.
    /// - Returns: Distance between 2 given points.
    public static func distance(from point: CGPoint, to destination: CGPoint) -> CGFloat {
        return sqrt(pow(destination.x - point.x, 2) + pow(destination.y - point.y, 2))
    }

    /// Calculates distance to point.
    ///
    /// - Parameter point: CGPoint to get distance from
    /// - Returns: Distance between self and given CGPoint.
    public func distance(to point: CGPoint) -> CGFloat {
        return CGPoint.distance(from: self, to: point)
    }
}
