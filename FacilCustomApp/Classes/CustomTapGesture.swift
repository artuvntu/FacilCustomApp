//
//  CustomTapGesture.swift
//  Cuenta Puntos
//
//  Created by Arturo Ventura on 11/12/22.
//

import UIKit

public class CustomTapGesture: UITapGestureRecognizer {
    private var action: () -> Void

    public init(action: @escaping () -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        self.addTarget(self, action: #selector(execute))
    }

    @objc private func execute() {
        action()
    }
}
