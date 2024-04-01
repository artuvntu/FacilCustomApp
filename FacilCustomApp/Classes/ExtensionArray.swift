//
//  ExtensionArray.swift
//  Cuenta Puntos
//
//  Created by Arturo Ventura on 11/12/22.
//

import Foundation

public extension Array {
    init(repeating: ((Int) -> Element), count: Int) {
        self = []
        for i in 0..<count {
            self.append(repeating(i))
        }
    }
}
