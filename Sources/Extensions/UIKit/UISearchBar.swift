//
//  UISearchBar.swift
//  BetterSwift
//
//  Created by Artem Bobrov on 07/10/2018.
//

import UIKit

public extension UISearchBar {
    /// Text field inside search bar (if applicable).
    public var textField: UITextField? {
        let subViews = subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }

    /// Text with no spaces or new lines in beginning and end (if applicable).
    public var trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public extension UISearchBar {
    /// Clear text.
    public func clear() {
        text = ""
    }
}
