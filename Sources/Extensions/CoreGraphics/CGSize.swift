//
//  CGSize.swift
//  BetterSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension CGSize {
    /// Aspect fits size into bounding size.
    ///
    /// - Parameter boundingSize: Bounding size to fit self to.
    /// - Returns: Self fitted into given bounding size.
    public func aspectFit(to boundingSize: CGSize) -> CGSize {
        let minRatio = min(boundingSize.width / width, boundingSize.height / height)
        return CGSize(width: width * minRatio, height: height * minRatio)
    }

    /// Aspect fills size into bounding size.
    ///
    /// - Parameter boundingSize: Bounding size to fill self to.
    /// - Returns: Self filled into given bounding size.
    public func aspectFill(to boundingSize: CGSize) -> CGSize {
        let aspectWidth = boundingSize.width / width
        let aspectHeight = boundingSize.height / height
        var size = CGSize(width: width, height: height)
        if aspectHeight > aspectWidth {
            size.width = aspectHeight * width
        } else if aspectHeight < aspectWidth {
            size.height = aspectWidth * height
        }
        return size
    }
}

public extension CGSize {
    ///  Multiply a CGSize with a scalar.
    ///
    /// - Parameters:
    ///   - lhs: CGSize to multiply.
    ///   - scalar: Scalar value.
    /// - Returns: The result comes from the multiplication of the given CGSize and scalar.
    public static func * (lhs: CGSize, scalar: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * scalar, height: lhs.height * scalar)
    }

    ///  Multiply self with a CGSize.
    ///
    /// - Parameters:
    ///   - lhs: Self.
    ///   - scalar: Scalar value.
    public static func *= (lhs: inout CGSize, scalar: CGFloat) {
        lhs.width *= scalar
        lhs.height *= scalar
    }
}
