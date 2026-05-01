//
//  AuthModels.swift
//  mobile
//
//  Created by Assistant on 01.05.2026.
//

import Foundation

// MARK: - Domain Models

struct AuthUser {
    let id: String
    let email: String
    let token: String
}

enum AuthError: Error, Equatable {
    case invalidCredentials
    case networkError
    case unauthorized
    case unknown
}

// MARK: - Input/Output Models

struct LoginInput {
    let email: String
    let password: String
}

struct LoginOutput {
    let user: AuthUser
}
