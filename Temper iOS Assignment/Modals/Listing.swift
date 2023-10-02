//
//  Listing.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import Foundation

struct Listing: Identifiable, Equatable {
    
    let id: String
    let startAt: Date
    let endsAt: Date
    let earningsPerHour: (amount: Double, currency: Currency)
    
    let job: Job
    
    init(dto: ListingDTO) throws {
        self.id = dto.id
        
        self.startAt = try dto.startsAt.toDate()
        self.endsAt = try dto.endsAt.toDate()
        
        let currency = Currency(shorthand: dto.earningsPerHour.currency)
        self.earningsPerHour = (dto.earningsPerHour.amount, currency)
        
        self.job = try Job(dto: dto.job)
    }
    
    static func == (lhs: Listing, rhs: Listing) -> Bool {
        lhs.id == rhs.id
    }
}
