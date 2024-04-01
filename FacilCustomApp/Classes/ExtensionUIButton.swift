//
//  ExtensionUIButton.swift
//  Cuenta Puntos
//
//  Created by Arturo Ventura on 11/12/22.
//

import UIKit

public extension UIButton {
    static func CustomInstance(font: UIFont, color: UIColor = UIColor.tintColor, text: String? = nil, action: (()->Void)? = nil) -> UIButton {
        let button = UIButton(type: .system)
        button.titleLabel?.font = font
        button.tintColor = color
        button.setTitle(text, for: .normal)
        if let action = action {
            button.addAction(action)
        }
        return button
    }
}

