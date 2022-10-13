//
//  ExtensionUIEdgeInsets.swift
//  Cuenta Puntos
//
//  Created by Arturo Ventura on 03/06/22.
//

import UIKit

public extension UIEdgeInsets {
    static func allSame(_ size: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: size, left: size, bottom: size, right: size)
    }
    
    static func axisSame(vertical: CGFloat, horizontal: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
