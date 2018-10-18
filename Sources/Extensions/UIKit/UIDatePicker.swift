//
//  UIDatePicker.swift
//  ConvenientSwift
//
//  Created by Artem Bobrov on 07/10/2018.
//

import UIKit

public extension UIDatePicker {
    /// Text color of UIDatePicker.
    public var textColor: UIColor? {
        set {
            setValue(newValue, forKeyPath: "textColor")
        }
        get {
            return value(forKeyPath: "textColor") as? UIColor
        }
    }
}
