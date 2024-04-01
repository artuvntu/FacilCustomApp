//
//  ExtensionCGSize.swift
//  Cuenta Puntos
//
//  Created by Arturo Ventura on 11/12/22.
//

import UIKit

public extension CGSize {
    static func WidthOnly(_ size: CGFloat) -> CGSize {
        CGSize(width: size, height: 0)
    }
    
    static func HeightOnly(_ size: CGFloat) -> CGSize {
        CGSize(width: 0, height: size)
    }
 }
