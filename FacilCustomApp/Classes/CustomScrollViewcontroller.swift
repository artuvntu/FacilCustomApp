//
//  CustomScrollViewController.swift
//  FacilApp
//
//  Created by Arturo Ventura on 15/01/22.
//

import UIKit

open class CustomScrollViewController: CustomViewController {
    weak var scrollView: UIScrollView!
    weak var contentView: UIView!
    weak var topContraint: NSLayoutConstraint!

    
    override public func loadView() {
        super.loadView()
        //        Scrollview
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        let topContraint = scrollView.topAnchor.constraint(equalTo: view.topAnchor)
        topContraint.isActive = true
        self.topContraint = topContraint
        let bottomConstraint = NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        bottomConstraint.isActive = true
        self.bottomConstraint = bottomConstraint
        scrollView.alwaysBounceVertical = true
        self.scrollView = scrollView
        //        ContentView
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.fillSuperView()
        contentView.anchor(centerX: scrollView.centerXAnchor, centerY: nil)
        self.contentView = contentView
    }
}
