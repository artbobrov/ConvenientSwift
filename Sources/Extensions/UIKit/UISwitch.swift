//
//  UISwitch.swift
//  BetterSwift
//
//  Created by Artem Bobrov on 07/10/2018.
//

import UIKit

public extension UISwitch {
    /// Toggle a UISwitch
    ///
    /// - Parameter animated: true to animate the change (default is true).
    public func toggle(animated: Bool = true) {
        setOn(!isOn, animated: animated)
    }
}
