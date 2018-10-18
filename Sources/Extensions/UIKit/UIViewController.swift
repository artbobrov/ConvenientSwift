//
//  UIViewController.swift
//  ConvenientSwift
//
//  Created by abobrov on 17/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import UIKit

public extension UIViewController {
    /// Check if ViewController is onscreen and not hidden.
    public var isVisible: Bool {
        return isViewLoaded && view.window != nil
    }
}

public extension UIViewController {
    /// Presents view controller for some time.
    ///
    /// - Parameters:
    ///   - viewController: view controller to present.
    ///   - duration: durection of presentation.
    ///   - animated: true to animate, false to make the presentation immediate.
    public func present(_ viewController: UIViewController, for duration: TimeInterval, animated: Bool = true) {
        present(viewController, animated: animated) {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
                viewController.dismiss(animated: animated, completion: nil)
            })
        }
    }
}

public extension UIViewController {
    /// Helper method to add a UIViewController as a childViewController.
    ///
    /// - Parameters:
    ///   - child: The view controller to add as a child.
    ///   - containerView: The containerView for the child viewcontroller's root view.
    public func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        addChild(child)
        child.willMove(toParent: self)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }

    /// Helper method to remove a UIViewController from its parent.
    public func removeViewAndControllerFromParentViewController() {
        guard parent != nil else { return }

        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
        didMove(toParent: nil)
    }
}
