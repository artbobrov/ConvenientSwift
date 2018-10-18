//
//  UIAlertController.swift
//  ConvenientSwift
//
//  Created by Artem Bobrov on 07/10/2018.
//

import UIKit

public extension UIAlertController {
    /// Add an action to alert.
    ///
    /// - Parameters:
    ///   - title: The text to use for the button title.
    ///   - style: Additional styling information to apply to the button
    ///   - isEnabled: A Boolean value indicating whether the action is currently enabled.
    ///   - handler: Block to execute when the user selects the action.
    /// - Returns: Newly created action.
    @discardableResult
    func addAction(title: String? = nil, style: UIAlertAction.Style = .default, isEnabled: Bool = true, handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        addAction(action)
        return action
    }

    /// Add text field to alert.
    ///
    /// - Parameters:
    ///   - text: The text displayed by the text field.
    ///   - placeholder: The string that is displayed when there is no other text in the text field.
    ///   - editingChangedTarget: An optional target for text field's editingChanged
    ///   - editingChangedSelector: An optional selector for text field's editingChanged
    public func addTextField(text: String? = nil, placeholder: String? = nil, editingChangedTarget: Any?, editingChangedSelector: Selector?) {
        addTextField { textField in
            textField.text = text
            textField.placeholder = placeholder
            if let target = editingChangedTarget, let selector = editingChangedSelector {
                textField.addTarget(target, action: selector, for: .editingChanged)
            }
        }
    }
}

public extension UIAlertController {
    /// Create new alert view controller with default OK action.
    ///
    /// - Parameters:
    ///   - title: Alert controller's title.
    ///   - message: Alert controller's message (default is nil).
    ///   - defaultActionButtonTitle: default action button title (default is "OK")
    ///   - tintColor: Alert controller's tint color (default is nil)
    public convenience init(title: String, message: String? = nil, defaultActionButtonTitle: String = "OK", tintColor: UIColor? = nil) {
        self.init(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: nil)
        addAction(defaultAction)
        if let color = tintColor {
            view.tintColor = color
        }
    }

    /// Create new error alert view controller from Error with default OK action.
    ///
    /// - Parameters:
    ///   - title: Alert controller's title.
    ///   - error: Error to set alert controller's message to it's localizedDescription.
    ///   - defaultActionButtonTitle: default action button title (default is "OK")
    ///   - tintColor: Alert controller's tint color (default is nil)
    public convenience init(title: String = "Error", error: Error, defaultActionButtonTitle: String = "OK", tintColor: UIColor? = nil) {
        self.init(title: title, message: error.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: nil)
        addAction(defaultAction)
        view.tintColor ??= tintColor
    }
}
