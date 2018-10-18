//
//  UITableView.swift
//  ConvenientSwift
//
//  Created by Artem Bobrov on 07/10/2018.
//

import UIKit

public extension UITableView {
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
