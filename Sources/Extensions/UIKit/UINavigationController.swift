//
//  UINavigationController.swift
//  ConvenientSwift
//
//  Created by Artem Bobrov on 07/10/2018.
//

import UIKit

public extension UINavigationController {
    /// Pop ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - animated: Set this value to true to animate the transition (default is true).
    ///   - completion: Optional completion handler (default is nil).
    public func popViewController(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }

    /// Push ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - viewController: ViewController to push.
    ///   - completion: Optional completion handler (default is nil).
    public func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
}
