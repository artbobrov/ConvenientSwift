//
//  UICollectionView.swift
//  BetterSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

public extension UICollectionView {
    /// Reload data with a completion handler.
    ///
    /// - Parameter completion: Completion handler to run after reloadData finishes.
    public func reloadData(_ completion: @escaping () -> Void) {
        reloadData()
        DispatchQueue.main.async {
            completion()
        }
    }
}
