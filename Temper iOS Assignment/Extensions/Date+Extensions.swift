//
//  Date+Extensions.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 02/10/2023.
//

import Foundation

enum DateFormats: String {
    case dashedDate = "yyyy-MM-dd"
    case dashedDateWithZone = "yyyy-MM-dd Z"
    case timeZone = "Z"
    case hourAndMin24h = "HH:MM"
    case dayMonthReadable = "EEEE d MMMM"
}

extension Date {
    func format(_ format: DateFormats) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        let formattedDate = formatter.string(from: self)
        return formattedDate
    }
    
    func isoDateFormat() -> String {
        let formatter = ISO8601DateFormatter()
        let formattedDate = formatter.string(from: self)
        return formattedDate
    }
    
    func convertToTimeZone(initTimeZone: TimeZone, timeZone: TimeZone) -> Date {
        let delta = TimeInterval(timeZone.secondsFromGMT(for: self) - initTimeZone.secondsFromGMT(for: self))
        return addingTimeInterval(delta)
    }
}
