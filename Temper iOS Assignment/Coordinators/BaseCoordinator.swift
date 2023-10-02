//
//  BaseCoordinator.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import UIKit

class BaseCoordinator {
    let dependencyContainer: DependencyContainer
    unowned var parentController: UINavigationController
    
    init(dependencyContainer: DependencyContainer, parentController: UINavigationController) {
        self.dependencyContainer = dependencyContainer
        self.parentController = parentController
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        parentController.present(alertController, animated: true, completion: nil)
    }
}
