//
//  UIView.swift
//  ConvenientSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension UIView {
    /// Get view's parent view controller
    public var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self

        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

public extension UIView {
    /// Finds first responder in view hierarchy.
    public var firstResponder: UIResponder? {
        guard !isFirstResponder else { return self }
        for view in subviews {
            if let responder = view.firstResponder {
                return responder
            }
        }
        return nil
    }

    /// Finds superview of a view by predicate.
    ///
    /// - Parameter predicate: Predicate to find.
    /// - Returns: superview of a view (of exists).
    func findSuperView(by predicate: (UIView) -> Bool) -> UIView? {
        return predicate(self) ? self : superview?.findSuperView(by: predicate)
    }

    /// Finds superview of a view by type.
    ///
    /// - Parameter type: Type to search.
    /// - Returns: superview of a view (of exists).
    func findSuperview<T: UIView>(byType type: T.Type) -> T? {
        return findSuperView(by: { $0 is T }) as? T
    }
}

public extension UIView {
    /// Remove all subviews from the view.
    public func removeSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }

    /// Remove all gesture recognizers from the view.
    public func removeGestureRecognizers() {
        gestureRecognizers?.forEach(removeGestureRecognizer)
    }
}
