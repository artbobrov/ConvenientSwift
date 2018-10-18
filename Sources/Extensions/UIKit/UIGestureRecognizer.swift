//
//  UIGestureRecognizer.swift
//  ConvenientSwift
//
//  Created by Artem Bobrov on 07/10/2018.
//

import UIKit

public extension UIGestureRecognizer {
    /// Removes gesture recognizer from the view.
    public func removeFromView() {
        view?.removeGestureRecognizer(self)
    }
}
