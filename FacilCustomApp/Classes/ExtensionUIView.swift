//
//  ExteensionView.swift
//  FacilApp
//
//  Created by Arturo Ventura on 10/07/22.
//

import UIKit

extension UIView{
    
    open func fillSuperView(padding: UIEdgeInsets = .zero){
        translatesAutoresizingMaskIntoConstraints  = false
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor,padding: padding)
    }
    open func fillSuperViewSafeArea(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: superview?.safeAreaLayoutGuide.topAnchor, leading: superview?.safeAreaLayoutGuide.leadingAnchor, bottom: superview?.safeAreaLayoutGuide.bottomAnchor, trailing: superview?.safeAreaLayoutGuide.trailingAnchor,padding: padding)
    }
    
    open func anchor(centerX : NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?){
        translatesAutoresizingMaskIntoConstraints  = false
        if let centerX = centerX{
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY{
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    open func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero){
        
        translatesAutoresizingMaskIntoConstraints  = false
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading{
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing{
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
    }
    open func anchor(size: CGSize) {
        translatesAutoresizingMaskIntoConstraints = false
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0{
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    open func anchor(aspectRatio:CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: aspectRatio, constant: 0).isActive = true
    }
    
    open func addSubviewAnchor(_ view: UIView, top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, centerX : NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, size: CGSize = .zero, aspectRatio:CGFloat? = nil) {
        self.addSubview(view)
        view.anchor(top: top, leading: leading, bottom: bottom, trailing: trailing, padding: padding)
        view.anchor(centerX: centerX, centerY: centerY)
        view.anchor(size: size)
        if let aspectRatio = aspectRatio {
            view.anchor(aspectRatio: aspectRatio)
        }
        
    }
    
    open func addSubviewFill(_ view: UIView, padding: UIEdgeInsets = .zero, safeArea: Bool = false) {
        self.addSubview(view)
        if safeArea {
            view.fillSuperViewSafeArea(padding: padding)
        } else {
            view.fillSuperView(padding: padding)
        }
    }
    
}

extension UIView {
    
    open var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        }
        return self.topAnchor
    }
    
    open var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leadingAnchor
        }
        return self.leadingAnchor
    }
    
    open var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.trailingAnchor
        }
        return self.trailingAnchor
    }
    
    open var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        }
        return self.bottomAnchor
    }
}

