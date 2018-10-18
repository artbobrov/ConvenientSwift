//
//  UIButton.swift
//  BetterSwift
//
//  Created by Artem Bobrov on 07/10/2018.
//

import UIKit

public extension UIButton {
    /// Center align title text and image on UIButton.
    ///
    /// - Parameter spacing: Spacing between UIButton title text and UIButton Image.
    public func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
}
