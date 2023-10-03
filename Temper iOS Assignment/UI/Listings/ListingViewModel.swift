//
//  ListingViewModel.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import Foundation
import Combine

enum AuthenticationType {
    case login
    case signUp
}

class ListingViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    private var pageIndex = 0
    
    @Published var listings: [Date: [Listing]]?
    
    @Published var isLoading: Bool = false
    
    @Published var currentDate = Date()
    @Published var lastFetchDate = Date()
    
    let coordinator: MainCoordinator
    let listingRepository: ListingRepository
    
    init(coordinator: MainCoordinator, listingRepository: ListingRepository) {
        self.coordinator = coordinator
        self.listingRepository = listingRepository
        
        listingRepository.$listings
            .receive(on: DispatchQueue.main)
            .assign(to: \.listings, on: self)
            .store(in: &cancellables)
    }
    
    func showAuthentication(type: AuthenticationType) {
        self.coordinator.showAuthentication(type: type)
    }
    
    func refreshListing() {
        isLoading = true
        self.currentDate = Date()
        self.lastFetchDate = self.currentDate
        self.pageIndex = 0
        Task {
            let list = await listingRepository.getListings(date: self.currentDate, force: true)
            Task.detached { @MainActor [weak self] in
                self?.isLoading = false
            }
            
            if let list = list, list.isEmpty {
                await loadMore()
            }
        }
    }
    
    func onAppear() {
        refreshListing()
    }
    
    func loadMore() async {
        Task { @MainActor in
            isLoading = true
            pageIndex += 1
            let modifiedDate = Calendar.current.date(byAdding: .day, value: pageIndex, to: self.currentDate)
            
            if let modifiedDate = modifiedDate {
                self.lastFetchDate = modifiedDate
                Task {
                    let list = await listingRepository.getListings(date: modifiedDate)
                    Task.detached { @MainActor [weak self] in
                        self?.isLoading = false
                    }
                    
                    if let list = list, list.isEmpty {
                        await loadMore()
                    }
                }
            }
        }
    }
}
