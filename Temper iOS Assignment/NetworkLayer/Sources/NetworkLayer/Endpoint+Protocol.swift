//
//  File.swift
//  
//
//  Created by Umur Yavuz on 01/10/2023.
//

import Foundation
import Alamofire

public protocol EndpointProtocol {
    var baseUrl: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpBody: Data? { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var responseType: Decodable.Type { get }
}

public struct Endpoint: EndpointProtocol {
    public var baseUrl: URL
    public var path: String
    public var httpMethod: HTTPMethod
    public var httpBody: Data?
    public var headers: HTTPHeaders
    public var parameters: Parameters?
    public var encoding: ParameterEncoding
    public var responseType: Decodable.Type
    
    public init(baseUrl: URL, path: String, httpMethod: HTTPMethod, httpBody: Data? = nil, headers: HTTPHeaders? = nil, queryParameters: [URLQueryItem]? = nil, encoding: ParameterEncoding = URLEncoding.default, responseType: Decodable.Type) {
        self.baseUrl = baseUrl
        self.path = path
        self.httpMethod = httpMethod
        self.httpBody = httpBody
        
        var headers_ = HTTPHeaders()
        if let headers = headers {
            headers_ = headers
        }
        self.headers = headers_
        
        let parameters: Parameters? = queryParameters?.reduce(into: Parameters()) { (result, queryItem) in
            result[queryItem.name] = queryItem.value
        }
        
        self.parameters = parameters
        self.encoding = encoding
        self.responseType = responseType
    }
}
