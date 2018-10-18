//
//  Create.swift
//  BetterSwift
//
//  Created by abobrov on 14/09/2018.
//  Copyright © 2018 Artem Bobrov. All rights reserved.
//

import Foundation

/// Convenient way to initialize and setup objects.
///
/// - Parameter setup: Closure with setup.
/// - Returns: Created instance.
public func create<T>(_ setup: ((T) -> Void)) -> T where T: NSObject {
    let object = T()
    setup(object)
    return object
}
