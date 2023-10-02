//
//  DependencyContainer.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import Foundation
import NetworkLayer

class DependencyContainer {
    static var shared: DependencyContainer = DependencyContainer()
    
    let networkLayer: NetworkManagerProtocol = NetworkManager()
    
    let listingRepository: ListingRepository
    
    init() {
        self.listingRepository = ListingRepository(networkLayer: networkLayer)
    }
}
