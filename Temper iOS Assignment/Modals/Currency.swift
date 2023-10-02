//
//  Currency.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import Foundation
enum Currency {
    case euro
    case unitedStatesDollar
    case unknown
    
    init(shorthand: String) {
        switch shorthand {
        case "EUR":
            self = .euro
        case "USD":
            self = .unitedStatesDollar
        default:
            self = .unknown
        }
    }
    
    var sign: String {
        switch self {
        case .euro:
            return "€"
        case .unitedStatesDollar:
            return "$"
        case .unknown:
            return "?"
        }
    }
}
