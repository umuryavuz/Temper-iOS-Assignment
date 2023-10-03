//
//  ListingRepository.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import Foundation
import NetworkLayer

class ListingRepository {
    @Published private(set) var listings: [Date : [Listing]]?
    private(set) lazy var listingsPublisher = $listings.eraseToAnyPublisher()
    
    let networkLayer: NetworkManagerProtocol
        
    init(networkLayer: NetworkManagerProtocol) {
        self.networkLayer = networkLayer
    }
    
    func getListings(date: Date, force: Bool = false) async -> [Listing]? {
        let formattedDate = date.format(.dashedDate)
        let queryItems = [URLQueryItem(name: Endpoint.shiftsDateQuery, value: formattedDate)]
        let endpoint = Endpoint.getListings(with: queryItems)
        
        let responseDTO: ListingDataDTO? = await networkLayer.requestWithHandledErrors(endpoint)
        
        if let responseDTO = responseDTO {
            if force {
                self.listings = nil
            }
            return self.mapResponse(with: responseDTO, date: date)
        }
        
        return nil
    }
    
    private func mapResponse(with responseDTO: ListingDataDTO, date: Date) -> [Listing] {
        var listingsArray: [Listing] = []
        for listing in responseDTO.data {
            do {
                let listing = try Listing(dto: listing)
                listingsArray.append(listing)
            } catch let error as DateParsingError {
                if case .invalidString = error {
                    print("Invalid Date string in Listing object: \(error.localizedDescription)")
                }
            } catch let error as URLError {
                if case .invalidString = error {
                    print("Invalid URL string in Listing object: \(error.localizedDescription)")
                }
            } catch {
                print("Unknown error: \(error.localizedDescription)")
            }
        }
        
        if self.listings == nil {
            self.listings = [:]
        }
        
        
        if !listingsArray.isEmpty {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            if let newDate = calendar.date(from: components) {
                let timeZone = TimeZone.current
                if let offsetDate = calendar.date(byAdding: .second, value: timeZone.secondsFromGMT(), to: newDate) {
                    self.listings?[offsetDate] = listingsArray
                }
            }
        }
        
        return listingsArray
    }
}
