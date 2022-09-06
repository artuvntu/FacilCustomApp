//
//  CustomInterceptor.swift
//  FacilApp
//
//  Created by Arturo Ventura on 21/02/22.
//

import Foundation
import Alamofire

class CustomInterceptor: RequestInterceptor {
    
    var shouldBeToken = false
    let token = "Dummy"
    init(shouldBeToken: Bool) {
        self.shouldBeToken = shouldBeToken
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if shouldBeToken {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        completion(.success(urlRequest))
    }
    
}
