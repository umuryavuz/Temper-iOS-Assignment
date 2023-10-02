//
//  JobDTO.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import Foundation

struct ListingDataDTO: Codable {
    let data: [ListingDTO]
}

struct ListingDTO: Codable {
    
    struct EarningsPerHour: Codable {
        let currency: String
        let amount: Double
    }
    
    let id: String
    let startsAt: String
    let endsAt: String
    let earningsPerHour: EarningsPerHour
    let job: JobDTO
    
    
    private enum CodingKeys: String, CodingKey {
        case id, job
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case earningsPerHour = "earnings_per_hour"
    }
}
