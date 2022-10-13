//
//  ExtensionUIImageView.swift
//  FacilApp
//
//  Created by Arturo Ventura on 27/11/21.
//

import UIKit
import SDWebImage

extension UIImageView {
    public func setImage(url:String?) {
        if let url = url {
            sd_setImage(with: URL(string: url))
        }
    }
    static public func enableToken() {
        let token = "Dummy"
        SDWebImageDownloader.shared.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    
    static public func disableToken() {
        SDWebImageDownloader.shared.setValue("", forHTTPHeaderField: "Authorization")
    }
}
