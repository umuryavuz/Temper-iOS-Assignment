//
//  Job.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import Foundation
import CoreLocation

struct Job {
    
    let id: String
    let jobTitle: String
    let clientName: String
    let clientImage: URL
    let categoryLocalized: String
    let location: CLLocation
    let distance: Int // in km rounded up
    
    init(dto: JobDTO) throws {
        self.id = dto.id
        self.jobTitle = dto.title
        self.clientName = dto.project.client.name
        guard let imageURL = URL(string: dto.project.client.links.heroImage) else {
            throw URLError.invalidString
        }
        
        self.clientImage = imageURL
        self.categoryLocalized = dto.category.nameTranslation.en_GB ?? ""
        self.location = CLLocation(latitude: dto.address.coordinates.latitude, longitude: dto.address.coordinates.longitude)
        
        // Calculating the distance from location set in Constants.swift file
        let amsterdamCentral = myLocation

        let distanceInMeters = amsterdamCentral.distance(from: self.location)
        let distanceInKilometers = distanceInMeters / 1000.0
        let roundedDistanceInKilometers = round(distanceInKilometers)
        self.distance = Int(roundedDistanceInKilometers)
    }
}
