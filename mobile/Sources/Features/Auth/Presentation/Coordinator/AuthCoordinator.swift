//
//  AuthCoordinator.swift
//  mobile
//
//  Created by Assistant on 01.05.2026.
//

import SwiftUI
import UIKit

final class AuthCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    weak var parentCoordinator: Coordinator?
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLogin()
    }
    
    private func showLogin() {
        // Create dependencies
        let apiService = MockAuthAPI() // Replace with real API service
        let repository = AuthRepository(apiService: apiService)
        let loginUseCase = LoginUseCase(repository: repository)
        
        // Create ViewModel
        let viewModel = AuthViewModel(loginUseCase: loginUseCase)
        
        // Create View
        let loginView = LoginView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: NavigationStack { loginView })
        
        // Observe navigation events
        viewModel.shouldNavigateToHome = false // Reset
        
        navigationController.setViewControllers([hostingController], animated: true)
    }
    
    func navigateToHome() {
        parentCoordinator?.showHome()
    }
}

// MARK: - Mock API for Demo

final class MockAuthAPI: AuthAPIProtocol {
    func login(email: String, password: String) async throws -> AuthResponseDTO {
        try await Task.sleep(nanoseconds: 1_000_000_000) // Simulate network delay
        
        if email == "test@example.com" && password == "password" {
            return AuthResponseDTO(id: "1", email: email, token: "mock_jwt_token")
        } else {
            throw AuthError.invalidCredentials
        }
    }
    
    func logout() async throws {
        // Mock logout
    }
}
