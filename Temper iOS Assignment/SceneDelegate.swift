//
//  SceneDelegate.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            setupInitialViewController(for: windowScene)
        }
    }
    
    private func setupInitialViewController(for windowScene: UIWindowScene) {
        let mainNavigationRoot = UINavigationController(nibName: nil, bundle: nil)
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = mainNavigationRoot
        window.makeKeyAndVisible()
        self.window = window
        //Initialise with main coordinator
        let mainCoordinator = MainCoordinator(dependencyContainer: .shared, parentController: mainNavigationRoot)
        mainCoordinator.start()
    }
    
}
