//
//  HomeCoordinator.swift
//  mobile
//
//  Created by Assistant on 01.05.2026.
//

import SwiftUI
import UIKit

final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    weak var parentCoordinator: Coordinator?
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHome()
    }
    
    private func showHome() {
        // Create dependencies
        let repository = MockHomeRepository() // Replace with real repository
        
        // Create ViewModel
        let viewModel = HomeViewModel(repository: repository)
        
        // Create View
        let homeView = HomeView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: homeView)
        
        navigationController.setViewControllers([hostingController], animated: true)
    }
}
