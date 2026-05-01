//
//  AuthViewModel.swift
//  mobile
//
//  Created by Assistant on 01.05.2026.
//

import Foundation
import Observation

@Observable
final class AuthViewModel {
    var email: String = ""
    var password: String = ""
    var isLoading: Bool = false
    var errorMessage: String?
    var shouldNavigateToHome: Bool = false
    
    private let loginUseCase: LoginUseCaseProtocol
    
    init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }
    
    func login() {
        guard !isLoading else { return }
        
        errorMessage = nil
        isLoading = true
        
        let input = LoginInput(email: email, password: password)
        
        Task {
            do {
                let output = try await loginUseCase.execute(input: input)
                print("Login successful for user: \(output.user.email)")
                shouldNavigateToHome = true
            } catch {
                handleError(error)
            }
            isLoading = false
        }
    }
    
    private func handleError(_ error: Error) {
        if let authError = error as? AuthError {
            switch authError {
            case .invalidCredentials:
                errorMessage = "Неверный email или пароль"
            case .networkError:
                errorMessage = "Ошибка сети"
            case .unauthorized:
                errorMessage = "Неавторизован"
            case .unknown:
                errorMessage = "Неизвестная ошибка"
            }
        } else {
            errorMessage = "Произошла ошибка"
        }
    }
}
