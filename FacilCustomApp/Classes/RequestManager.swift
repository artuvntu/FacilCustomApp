//
//  RequestManager.swift
//  FacilApp
//
//  Created by Arturo Ventura on 20/11/21.
//

import Foundation
import Alamofire

typealias DummyCodable = [String: String]
typealias SuccessClosure<T: Decodable> = ((T) -> Void)?
typealias SuccessClosureCode<T: Decodable> = ((Int?, T) -> Void)?
typealias ErrorClosure<T: Decodable> = ((Int?, T?) -> Void)?
fileprivate let Nulo = Optional<String>.none
class RequestManager {
    
    static let shared = RequestManager()
    
    lazy var session: Session = { AF }()
    let boundary = UUID().uuidString
    var modifier: Session.RequestModifier? = nil
    
    func make<Out:Decodable, Err: Decodable, InBody: Encodable>(url:URLConvertible, method: HTTPMethod, headers: HTTPHeaders?, body: InBody?, shouldBeToken: Bool, successClosure: SuccessClosure<Out>, errorClosure: ErrorClosure<Err>) {
        func response(data: DataResponse<Out, AFError> ) {
            print(data.debugDescription)
            switch data.result {
            case let .success(value):
                successClosure?(value)
                break
            case .failure:
                let errorData: Err? = (data.data != nil ? (try? JSONDecoder().decode(Err.self, from: data.data!)) : nil)
                errorClosure?(data.response?.statusCode, errorData)
                break
            }
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        session.request(url, method: method, parameters: body, encoder: JSONParameterEncoder.default, headers: ["Content-Type": "application/json"], interceptor: CustomInterceptor(shouldBeToken: shouldBeToken), requestModifier: modifier).cURLDescription(calling: { curl in
            print(curl)
        }).validate(statusCode: 200..<300)
            .responseDecodable(of: Out.self, decoder: decoder, completionHandler: response(data:))
    }
    
    func makeCode<Out:Decodable, Err: Decodable, InBody: Encodable>(url:URLConvertible, method: HTTPMethod, headers: HTTPHeaders?, body: InBody?, shouldBeToken: Bool, successClosure: SuccessClosureCode<Out>, errorClosure: ErrorClosure<Err>) {
        func response(data: DataResponse<Out, AFError> ) {
            print(data.debugDescription)
            switch data.result {
            case let .success(value):
                successClosure?(data.response?.statusCode, value)
                break
            case .failure:
                let errorData: Err? = (data.data != nil ? (try? JSONDecoder().decode(Err.self, from: data.data!)) : nil)
                errorClosure?(data.response?.statusCode, errorData)
                break
            }
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        session.request(url, method: method, parameters: body, encoder: JSONParameterEncoder.default, headers: ["Content-Type": "application/json"], interceptor: CustomInterceptor(shouldBeToken: shouldBeToken), requestModifier: modifier).cURLDescription(calling: { curl in
            print(curl)
        }).responseDecodable(of: Out.self, decoder: decoder, completionHandler: response(data:))
    }
    
    func makeMutipartCode<Out:Decodable, Err: Decodable>(url:URLConvertible, method: HTTPMethod, headers: HTTPHeaders?, body: [String:URL]?, shouldBeToken: Bool, successClosure: SuccessClosureCode<Out>, errorClosure: ErrorClosure<Err>) {
        func response(data: DataResponse<Out, AFError> ) {
            print(data.debugDescription)
            switch data.result {
            case let .success(value):
                successClosure?(data.response?.statusCode, value)
                break
            case .failure:
                let errorData: Err? = (data.data != nil ? (try? JSONDecoder().decode(Err.self, from: data.data!)) : nil)
                errorClosure?(data.response?.statusCode, errorData)
                break
            }
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        session.upload(multipartFormData: { [body] (multipartFormData) in
            if let params = body {
                for param in params {
                    multipartFormData.append(param.value, withName: param.key)
                }
            }
        }, to: url, method: method, headers: ["Content-Type": "multipart/form-data; boundary=\(boundary)"], interceptor: CustomInterceptor(shouldBeToken: shouldBeToken), requestModifier: modifier).cURLDescription(calling: {print($0)}).responseDecodable(of: Out.self, decoder: decoder, completionHandler: response(data:))
    }
    
}
