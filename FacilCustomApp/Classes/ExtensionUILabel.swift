//
//  ExtensionUIButton.swift
//  Cuenta Puntos
//
//  Created by Arturo Ventura on 11/12/22.
//

import UIKit

public extension UILabel {
    
    convenience init(font: UIFont, color: UIColor = .black, text: String? = nil, textAlignment: NSTextAlignment = .left) {
        self.init(frame: .zero)
        self.font = font
        self.textColor = color
        self.text = text
        self.textAlignment = textAlignment
    }
    
    static func CustomInstance(font: UIFont, color: UIColor = .black, text: String? = nil, textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.text = text
        label.textAlignment = textAlignment
        return label
    }
    
//    static func CustomInstance(font: FontDefault, size: CGFloat, color: UIColor = .black, text: String? = nil, textAlignment: NSTextAlignment = .left) -> UILabel {
//        CustomInstance(font: font.of(size: size), color: color, text: text, textAlignment: textAlignment)
//    }
//    
//    static func CustomInstance(font: FontDefault, size: FontSizes, color: UIColor = .black, text: String? = nil, textAlignment: NSTextAlignment = .left) -> UILabel {
//        CustomInstance(font: font, size: size.rawValue, color: color, text: text, textAlignment: textAlignment)
//    }
}
