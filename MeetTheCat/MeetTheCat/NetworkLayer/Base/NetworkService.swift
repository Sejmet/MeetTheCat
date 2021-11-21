//
//  NetworkService.swift
//  MeetTheCat
//
//  Created by Sejmet on 20/11/2021.
//

import Foundation
import Alamofire

public protocol NetworkServiceProtocol: AnyObject {
    func execute(_ urlRequest: URLRequestBuilder, completion: @escaping ((_ response: AFDataResponse<Any>, _ error: AFError?) -> Void))
}

public extension NetworkServiceProtocol {
    func execute(_ urlRequest: URLRequestBuilder, completion: @escaping ((_ response: AFDataResponse<Any>, _ error: AFError?) -> Void)) {
        AF.request(urlRequest).validate().responseJSON { (dataResponse) in
            completion(dataResponse, dataResponse.error)
        }
    }
}

public class NetworkService: NetworkServiceProtocol {
    public static let `default`: NetworkServiceProtocol = {
        var service = NetworkService()
        return service
    }()
}
