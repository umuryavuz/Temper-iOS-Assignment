// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Alamofire

@available(iOS 13.0.0, *)
public protocol NetworkManagerProtocol {
    func requestWithHandledErrors<T: Decodable>(_ endpoint: Endpoint) async -> T?
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

public class NetworkManager {
    
    private var session: Session
    
    public init() {
        self.session = Session(eventMonitors: [AlamofireLogger()] )
    }
    
    @available(iOS 13.0.0, *)
    public func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let url = URL(string: "\(endpoint.baseUrl)\(endpoint.path)")!
        let headers = endpoint.headers
        let parameters = endpoint.parameters
        let encoding = endpoint.encoding
        let httpMethod = endpoint.httpMethod
        
        let request = session.request(
            url,
            method: httpMethod,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
        .serializingDecodable(T.self)
        
        let response = await request.response
        let result = await request.result

        do {
            let value = try await request.value
            return value
        } catch let error as AFError {
                switch error.responseCode {
                    case 400: throw NetworkError.badRequest
                    case 401: throw NetworkError.unauthorized
                    case 404: throw NetworkError.notFound
                    default: throw NetworkError.badRequest
                }
            } catch let error as DecodingError {
                throw NetworkError.serializationError(error.localizedDescription)
            }
    }
}


@available(iOS 13.0.0, *)
extension NetworkManager: NetworkManagerProtocol {
    
    public func requestWithHandledErrors<T: Decodable>(_ endpoint: Endpoint) async -> T? {
        do {
            let response: T = try await request(endpoint)
            return response
        } catch let error as NetworkError {
            print("Network error handled: \(error)")
            return nil
        } catch {
            print("Other error: \(error)")
            return nil
        }
    }
    
}
