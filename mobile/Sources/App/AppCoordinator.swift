//
//  AppCoordinator.swift
//  mobile
//
//  Created by Assistant on 01.05.2026.
//

import SwiftUI
import Observation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

@Observable
final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let authCoordinator = AuthCoordinator(navigationController: UINavigationController())
        authCoordinator.parentCoordinator = self
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
        
        window.rootViewController = authCoordinator.navigationController
        window.makeKeyAndVisible()
    }
    
    func showHome() {
        let homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
        
        // Remove auth coordinator
        if let index = childCoordinators.firstIndex(where: { $0 is AuthCoordinator }) {
            childCoordinators.remove(at: index)
        }
        
        window.rootViewController = homeCoordinator.navigationController
        window.makeKeyAndVisible()
    }
}
