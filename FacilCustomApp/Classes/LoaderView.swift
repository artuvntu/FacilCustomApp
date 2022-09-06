//
//  LoaderView.swift
//  FacilApp
//
//  Created by Arturo Ventura on 13/12/21.
//

import UIKit


class LoaderView: UIView{
    
    private lazy var actInd:SpinnerView = {
        let aiv = SpinnerView()
        return aiv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        let loadingView: UIView = UIView()
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        
        loadingView.addSubview(actInd)
        
        actInd.anchor(top: loadingView.topAnchor, leading: loadingView.leadingAnchor, bottom: loadingView.bottomAnchor, trailing: loadingView.trailingAnchor, padding: .AllSame(value: 8))
        actInd.anchor(size: CGSize(width: 80, height: 80))
        addSubview(loadingView)
        
        loadingView.anchor(centerY: centerYAnchor, centerX: centerXAnchor)
    }
    
    
    func startIndicator(){
        
    }
    
    func stopIndicator() {
        
    }
}
