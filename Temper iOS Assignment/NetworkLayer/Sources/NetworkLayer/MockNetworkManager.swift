//
//  File.swift
//  
//
//  Created by Umur Yavuz on 03/10/2023.
//

import Foundation
@available(iOS 13.0.0, *)
public class MockNetworkManager: NetworkManagerProtocol {
    public var mockResponse: Any?
    
    public func requestWithHandledErrors<T: Decodable>(_ endpoint: Endpoint) async -> T? {
        print("MockNetworkManager: Returning mock data")
        return mockResponse as? T
    }
    
    public func request<T>(_ endpoint: Endpoint) async throws -> T where T : Decodable {
        // Implement your mocking logic here
        throw NetworkError.badRequest
    }
    
    public init(mockResponse: Any? = nil) {
        self.mockResponse = mockResponse
    }
}
