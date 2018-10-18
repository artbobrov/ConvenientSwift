//
//  UIStackView.swift
//  BetterSwift
//
//  Created by Artem Bobrov on 07/10/2018.
//

import UIKit

public extension UIStackView {
    /// Adds array of views to the end of the arrangedSubviews array.
    ///
    /// - Parameter views: views array.
    public func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }

    /// Removes all views in stack’s array of arranged subviews.
    public func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
    }
}
