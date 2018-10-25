//
//  Weak.swift
//  ConvenientSwift
//
//  Created by Artem Bobrov on 22/10/2018.
//

import Foundation

/// Class that contains weak reference to object.
///
/// 	let label = UILabel()
/// 	let view = UIView()
/// 	let array: [Weak<UIView>] = [label, view] // array with weak properties
///
public class Weak<T: AnyObject> {
    public weak var value: T?

    public init(value: T) {
        self.value = value
    }

    public init(_ value: T) {
        self.value = value
    }
}
