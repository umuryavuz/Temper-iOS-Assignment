//
//  URL+Extensions.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import Foundation

extension URL {
    static var temper: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Bundle.main.infoDictionary?["TEMPER_API_HOST"] as? String
        return components.url!
    }
}
