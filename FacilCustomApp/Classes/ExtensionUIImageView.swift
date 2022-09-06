//
//  ExtensionUIImageView.swift
//  FacilApp
//
//  Created by Arturo Ventura on 27/11/21.
//

import UIKit
import SDWebImage

extension UIImageView {
    func setImage(url:String?) {
        if let url = url {
            sd_setImage(with: URL(string: url))
        }
    }
    static func enableToken() {
        let token = "Dummy"
        SDWebImageDownloader.shared.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    
    static func disableToken() {
        SDWebImageDownloader.shared.setValue("", forHTTPHeaderField: "Authorization")
    }
}
