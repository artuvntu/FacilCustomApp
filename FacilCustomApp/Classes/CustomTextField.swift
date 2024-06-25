//
//  CustomTextField.swift
//  Cuenta Puntos
//
//  Created by Arturo Ventura on 05/06/22.
//

import UIKit


open class CustomTextField: UIView, UITextFieldDelegate {
    weak public var textField: UITextField!
    public var listener: CustomTextFieldListener?
    public var filter: CustomTextFieldFilter?
    
    public var text: String? {
        set {
            textField.text = newValue
        }
        get {
            textField.text
        }
    }
    
    public init(listener: CustomTextFieldListener? = nil, filter: CustomTextFieldFilter? = nil, text: String? = nil) {
        self.listener = listener
        super.init(frame: .zero)
        let textField = UITextField()
        addTextField(textField: textField)
        self.textField = textField
        textField.text = text
        textField.borderStyle = .none
        textField.delegate = self
    }
    
    open func addTextField(textField: UITextField) {
        addSubviewFill(textField)
    }
    
    required public init?(coder: NSCoder) {
        fatalError()
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let textRange = Range(range, in: currentText)!
        let newText = currentText.replacingCharacters(in: textRange, with: string)
        if string == "\n" {
            listener?.onDonePress(view: self)
            return false
        }
        let shouldChangeCharacters = filter?.filter(finalValue: newText) ?? true
        if shouldChangeCharacters {
            self.listener?.onKeyPress(view: self, text: newText)
        }
        return shouldChangeCharacters
    }
    
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        // NO OP
    }
    
}

public protocol CustomTextFieldListener: NSObject {
    func onDonePress(view: CustomTextField)
    func onKeyPress(view: CustomTextField, text:String)
}

public extension CustomTextFieldListener {
    func onDonePress(view: CustomTextField) {}
    func onKeyPress(view: CustomTextField, text:String) {}
}

public protocol CustomTextFieldFilter {
    func filter(finalValue: String) -> Bool
}
