//
//  ListingRepositoryTests.swift
//  Temper iOS AssignmentTests
//
//  Created by Umur Yavuz on 02/10/2023.
//

import XCTest
import NetworkLayer
//@testable import Temper_iOS_Assignment

class ListingRepositoryTests: XCTestCase {
    
    var repository: ListingRepository!
    var mockNetworkManager: MockNetworkManager!
    var mockListing: ListingDataDTO!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        repository = ListingRepository(networkLayer: mockNetworkManager)
        mockListing = setUpMockData()
    }
    
    func setUpMockData() -> ListingDataDTO {
        // Mock EarningsPerHour
        let mockEarnings = ListingDTO.EarningsPerHour(currency: "EUR", amount: 14.0)
        // Mock Links for ClientDTO
        let mockClientLinks = JobDTO.ClientDTO.LinksDTO(heroImage: "https://example.com/hero_image.jpg", thumbImage: "https://example.com/thumb_image.jpg")
        // Mock ClientDTO
        let mockClient = JobDTO.ClientDTO(name: "TenneT Hoogeveen", links: mockClientLinks)
        // Mock ProjectDTO
        let mockProject = JobDTO.ProjectDTO(client: mockClient)
        // Mock NameTranslation for CategoryDTO
        let mockNameTranslation = JobDTO.CategoryDTO.NameTranslationDTO(en_GB: "Catering")
        // Mock CategoryDTO
        let mockCategory = JobDTO.CategoryDTO(nameTranslation: mockNameTranslation)
        // Mock Coordinates for AddressDTO
        let mockCoordinates = JobDTO.AddressDTO.CoordinatesDTO(latitude: 52.738273, longitude: 6.470003)
        // Mock AddressDTO
        let mockAddress = JobDTO.AddressDTO(coordinates: mockCoordinates)
        // Mock JobDTO
        let mockJob = JobDTO(id: "q6vpyg", title: "Catering medewerker", project: mockProject, category: mockCategory, address: mockAddress)
        // Mock ListingDTO
        let mockListing = ListingDTO(id: "y9azzrw", startsAt: "2023-10-03T10:30:00+02:00", endsAt: "2023-10-03T14:00:00+02:00", earningsPerHour: mockEarnings, job: mockJob)
        // Mock ListingDataDTO
        let mockListingData = ListingDataDTO(data: [mockListing])
        
        return mockListingData
    }
    
    func testGetListingsWithValidDate() async throws {
        let date = Date()
        
        mockNetworkManager.mockResponse = mockListing
        
        let listingArray = await repository.getListings(date: date)
        
        XCTAssertNotNil(listingArray)
    }
    
    func testGetListingsWithEmptyResponse() async throws {
        mockNetworkManager.mockResponse = nil
        let date = Date()
        let listingArray = await repository.getListings(date: date)
        XCTAssertNil(listingArray)
    }
    
    func testGetListingsDataMapping() async throws {
        let date = Date()
        mockNetworkManager.mockResponse = mockListing
        let listingArray = await repository.getListings(date: date)
        guard let firstListing = listingArray?.first else {
            XCTFail("Expected non-empty listing array")
            return
        }
        
        XCTAssertEqual(firstListing.id, "y9azzrw")
        XCTAssertEqual(firstListing.startAt.format(.dashedDate), "2023-10-03")
        XCTAssertEqual(firstListing.endsAt.format(.dashedDate), "2023-10-03")
        XCTAssertEqual(firstListing.earningsPerHour.currency.sign, "€")
        XCTAssertEqual(firstListing.earningsPerHour.amount, 14.0)
        XCTAssertEqual(firstListing.job.id, "q6vpyg")
        XCTAssertEqual(firstListing.job.jobTitle, "Catering medewerker")
        XCTAssertEqual(firstListing.job.clientName, "TenneT Hoogeveen")
        XCTAssertEqual(firstListing.job.clientImage, URL(string: "https://example.com/hero_image.jpg"))
        XCTAssertEqual(firstListing.job.categoryLocalized, "Catering")
        XCTAssertEqual(firstListing.job.location.coordinate.latitude, 52.738273)
        XCTAssertEqual(firstListing.job.location.coordinate.longitude, 6.470003)
    }
    
    func testGetMultipleListings() async throws {
        let date = Date()
        mockNetworkManager.mockResponse = mockListing
        let _ = await repository.getListings(date: date)
        
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: date)
        let _ = await repository.getListings(date: tomorrow!)
        
        XCTAssertEqual(repository.listings?.count, 2)
    }
}
