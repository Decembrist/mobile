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
    
    weak var parentCoordinator: AppCoordinator?
    
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
        
        navigationController.setViewControllers([hostingController], animated: true)
        
        // Observe navigation events using Observation framework
        Task { @MainActor in
            do {
                try await Task.sleep(nanoseconds: 100_000_000) // Small delay to allow view setup
                while true {
                    if viewModel.shouldNavigateToHome {
                        navigateToHome()
                        break
                    }
                    try await Task.sleep(nanoseconds: 100_000_000) // Check every 100ms
                }
            } catch {}
        }
    }
    
    func navigateToHome() {
        parentCoordinator?.showHome()
    }
}

// MARK: - Mock API for Demo

final class MockAuthAPI: AuthAPIProtocol {
    func login(email: String, password: String) async throws -> AuthResponseDTO {
        try await Task.sleep(nanoseconds: 1_000_000_000) // Simulate network delay
        
        if email == "admin" && password == "admin" {
            return AuthResponseDTO(id: "1", email: email, token: "mock_jwt_token")
        } else {
            throw AuthError.invalidCredentials
        }
    }
    
    func logout() async throws {
        // Mock logout
    }
}
