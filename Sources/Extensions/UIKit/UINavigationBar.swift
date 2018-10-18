//
//  UINavigationBar.swift
//  ConvenientSwift
//
//  Created by Artem Bobrov on 07/10/2018.
//

import UIKit

public extension UINavigationBar {
    /// Make navigation bar transparent.
    ///
    /// - Parameter tint: Tint color (default is .white).
    public func makeTransparent(withTint tint: UIColor = .white) {
        isTranslucent = true
        backgroundColor = .clear
        barTintColor = .clear
        setBackgroundImage(UIImage(), for: .default)
        tintColor = tint
        titleTextAttributes = [.foregroundColor: tint]
        shadowImage = UIImage()
    }
}
