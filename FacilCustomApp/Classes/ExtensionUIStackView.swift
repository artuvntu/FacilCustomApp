//
//  ExtensionUIStackView.swift
//  FacilCustomApp
//
//  Created by Arturo Ventura on 11/10/22.
//

import UIKit

extension UIStackView {
    static public func CustomInstance(axis: NSLayoutConstraint.Axis, distribution: Distribution = .fill, alignment: Alignment = .fill, spacing: CGFloat = 0.0, arrangedSubviews: [UIView]? = nil) -> UIStackView {
        let stackView: UIStackView
        if let arrangedSubviews = arrangedSubviews {
            stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        } else {
            stackView = UIStackView()
        }
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.alignment = alignment
        stackView.spacing = spacing
        return stackView
    }
}
