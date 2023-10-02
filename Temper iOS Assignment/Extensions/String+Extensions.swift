//
//  String+Extensions.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 02/10/2023.
//

import Foundation

extension String {
    func toDate() throws -> Date {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: self) else {
            print("Invalid data string: \(self)")
            throw DateParsingError.invalidString
        }
        return date
    }
}
