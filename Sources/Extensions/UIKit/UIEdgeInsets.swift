//
//  UIEdgeInsets.swift
//  ConvenientSwift
//
//  Created by Artem Bobrov on 07/10/2018.
//

import UIKit

extension UIEdgeInsets {
    /// Returns the vertical insets. The vertical insets is composed by top + bottom.
    public var vertical: CGFloat {
        return top + bottom
    }

    /// Returns the horizontal insets. The horizontal insets is composed by  left + right.
    public var horizontal: CGFloat {
        return left + right
    }
}

extension UIEdgeInsets {
    /// Creates an `UIEdgeInsets` with the inset value applied to all (top, bottom, right, left)
    ///
    /// - Parameter inset: Inset to be applied in all the edges.
    public init(inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }

    /// Creates an `UIEdgeInsets` with the horizontal value equally divided and applied to right and left. And the vertical value equally divided and applied to top and bottom.
    ///
    /// - Parameters:
    ///   - horizontal: Inset to be applied to right and left.
    ///   - vertical: Inset to be applied to top and bottom.
    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical / 2, left: horizontal / 2, bottom: vertical / 2, right: horizontal / 2)
    }

    /// Creates an `UIEdgeInsets` based on current value and top offset.
    ///
    /// - Parameter top: Offset to be applied in to the top edge.
    /// - Returns: UIEdgeInsets offset with given offset.
    public func insetBy(top: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.top + top, left: left, bottom: bottom, right: right)
    }

    /// Creates an `UIEdgeInsets` based on current value and left offset.
    ///
    /// - Parameter left: Offset to be applied in to the left edge.
    /// - Returns: UIEdgeInsets offset with given offset.
    public func insetBy(left: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: self.left + left, bottom: bottom, right: right)
    }

    /// Creates an `UIEdgeInsets` based on current value and bottom offset.
    ///
    /// - Parameter bottom: Offset to be applied in to the bottom edge.
    /// - Returns: UIEdgeInsets offset with given offset.
    public func insetBy(bottom: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: self.bottom + bottom, right: right)
    }

    /// Creates an `UIEdgeInsets` based on current value and right offset.
    ///
    /// - Parameter right: Offset to be applied in to the right edge.
    /// - Returns: UIEdgeInsets offset with given offset.
    public func insetBy(right: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: self.right + right)
    }

    /// Creates an `UIEdgeInsets` based on current value and horizontal value equally divided and applied to right offset and left offset.
    ///
    /// - Parameter horizontal: Offset to be applied to right and left.
    /// - Returns: UIEdgeInsets offset with given offset.
    public func insetBy(horizontal: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left + horizontal / 2, bottom: bottom, right: right + horizontal / 2)
    }

    /// Creates an `UIEdgeInsets` based on current value and vertical value equally divided and applied to top and bottom.
    ///
    /// - Parameter vertical: Offset to be applied to top and bottom.
    /// - Returns: UIEdgeInsets offset with given offset.
    public func insetBy(vertical: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: top + vertical / 2, left: left, bottom: bottom + vertical / 2, right: right)
    }
}
