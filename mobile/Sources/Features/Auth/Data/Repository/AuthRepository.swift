//
//  AuthRepository.swift
//  mobile
//
//  Created by Assistant on 01.05.2026.
//

import Foundation

final class AuthRepository: AuthRepositoryProtocol {
    private let apiService: AuthAPIProtocol
    
    init(apiService: AuthAPIProtocol) {
        self.apiService = apiService
    }
    
    func login(email: String, password: String) async throws -> AuthUser {
        let response = try await apiService.login(email: email, password: password)
        return response.toDomain()
    }
    
    func logout() async throws {
        // Clear local storage, tokens, etc.
        try await apiService.logout()
    }
    
    func getCurrentUser() async throws -> AuthUser? {
        // Check for stored token and fetch user data
        return nil
    }
}
