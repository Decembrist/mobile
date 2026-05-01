//
//  LoginUseCase.swift
//  mobile
//
//  Created by Assistant on 01.05.2026.
//

import Foundation

protocol LoginUseCaseProtocol {
    func execute(input: LoginInput) async throws -> LoginOutput
}

final class LoginUseCase: LoginUseCaseProtocol {
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(input: LoginInput) async throws -> LoginOutput {
        guard !input.email.isEmpty, !input.password.isEmpty else {
            throw AuthError.invalidCredentials
        }
        
        let user = try await repository.login(email: input.email, password: input.password)
        return LoginOutput(user: user)
    }
}
