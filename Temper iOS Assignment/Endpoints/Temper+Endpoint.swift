//
//  Temper+Endpoint.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import Foundation
import NetworkLayer

extension Endpoint {
    static var shiftsDateQuery: String = "filter[date]"
    static func getListings(with queryItems: [URLQueryItem]? = nil) -> Endpoint {
        .init(baseUrl: .temper, path: "/api/v3/shifts", httpMethod: .get, queryParameters: queryItems, responseType: ListingDataDTO.self)
    }
}

