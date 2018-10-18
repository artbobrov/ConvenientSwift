//
//  UIStoryboard.swift
//  ConvenientSwift
//
//  Created by Artem Bobrov on 07/10/2018.
//

import UIKit

public extension UIStoryboard {
    /// Get main storyboard for application.
    public static var main: UIStoryboard? {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else { return nil }
        return UIStoryboard(name: name, bundle: bundle)
    }
}

public extension UIStoryboard {
    /// Instantiate a UIViewController using its class name
    ///
    /// - Parameter name: UIViewController type.
    /// - Returns: The view controller corresponding to specified class name.
    public func instantiateViewController<T: UIViewController>(ofType name: T.Type) -> T? {
        return instantiateViewController(withIdentifier: String(describing: name)) as? T
    }
}
