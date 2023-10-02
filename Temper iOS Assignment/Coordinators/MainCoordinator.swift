//
//  MainCoordinator.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import UIKit

class MainCoordinator: BaseCoordinator {
    
    func start() {
        // Start the main navigation route
        let viewModel = ListingViewModel(coordinator: self, listingRepository: dependencyContainer.listingRepository)
        let controller = ListingViewController(viewModel: viewModel)
        
        parentController.setViewControllers([controller], animated: false)
        
    }
    
    func showAuthentication(type: AuthenticationType) {
        let controller = AuthenticationViewController(type: type)
        parentController.present(controller, animated: true)
    }
}
