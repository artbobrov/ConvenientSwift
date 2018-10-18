//
//  CGFloat.swift
//  ConvenientSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension CGFloat {
    /// Converts degress to radians.
    public var degreesToRadians: CGFloat {
        return .pi * self / 180.0
    }

    /// Converts radians to degress.
    public var radiansToDegrees: CGFloat {
        return self * 180 / CGFloat.pi
    }
}
