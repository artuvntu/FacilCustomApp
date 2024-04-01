//
//  CustomViewController.swift
//  FacilApp
//
//  Created by Arturo Ventura on 20/11/21.
//

import UIKit

open class CustomViewController: UIViewController {
    
    public weak var bottomConstraint: NSLayoutConstraint?
    
    open func hasTextField() -> Bool { false }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func retry() {
    }
    
    open override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    open override func viewDidLoad() {
        if hasTextField() {
            setupHideKeyboardOnTap()
            enableKeyBoardToggle()
        }
    }
    
    
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
    
    func enableKeyBoardToggle(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardWillChangeLogic(isShow: true, keyboardHeight: keyboardSize.height)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        keyboardWillChangeLogic(isShow: false, keyboardHeight: 0)
    }
    
    @objc func keyboardWillChangeLogic(isShow:Bool, keyboardHeight: CGFloat) {
        if let bottomConstraint = bottomConstraint {
            UIView.animate(withDuration: 0.25) {
                bottomConstraint.constant = -(isShow ? keyboardHeight : 0)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func getFirstResponder(view: UIView?) -> UIView?{
        if view == nil || view!.isFirstResponder {
            return view
        }else {
            var respuesta:UIView? = nil
            for v in view?.subviews ?? [] {
                respuesta = getFirstResponder(view: v)
                if respuesta != nil {
                    break
                }
            }
            return respuesta
        }
    }
    
    
    func showLoader(){
        hideLoader()
        
        let loader = LoaderView()
        view.addSubview(loader)
        loader.anchor(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        loader.anchor(size: CGSize(width: view.frame.width, height: view.frame.height))
        
        loader.startIndicator()
        
    }
    
    func hideLoader(){
        view.subviews.forEach { currentView in
            if let loader = currentView as? LoaderView{
                loader.stopIndicator()
                loader.removeFromSuperview()
            }
        }
    }
    
}
