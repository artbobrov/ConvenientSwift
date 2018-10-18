//
//  UIScrollView.swift
//  ConvenientSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension UIScrollView {
    /// Scrolls to bottom.
    ///
    /// - Parameter animated: true to animate, false to make the scroll immediate.
    public func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }

    /// Scrolls to top.
    ///
    /// - Parameter animated: true to animate, false to make the scroll immediate.
    public func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
}
