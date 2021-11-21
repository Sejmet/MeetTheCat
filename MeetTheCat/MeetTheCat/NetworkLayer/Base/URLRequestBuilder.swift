//
//  URLRequestBuilder.swift
//  MeetTheCat
//
//  Created by Sejmet on 20/11/2021.
//

import Foundation
import Alamofire

public protocol URLRequestBuilder: URLRequestConvertible {
    var baseURL: URL { get }
    var requestURL: URL { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var urlRequest: URLRequest { get }
}

extension URLRequestBuilder {
    
    var baseURL: URL {
        return AppEnvironement.baseURL
    }
    
    var requestURL: URL {
        return baseURL.appendingPathComponent(path, isDirectory: false)
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var headers: HTTPHeaders {
        let header: HTTPHeaders = [HTTPHeader(name: "X-API-KEY", value: "5d6b4c68-5a44-40e3-bef3-1c77ff5688f1")]
        return header
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.name)
        }
        return request
    }
    
    public func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
}
