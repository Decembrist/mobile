//
//  AuthDTOs.swift
//  mobile
//
//  Created by Assistant on 01.05.2026.
//

import Foundation

// MARK: - DTO Models

struct AuthResponseDTO: Codable {
    let id: String
    let email: String
    let token: String
}

// MARK: - Mapping to Domain

extension AuthResponseDTO {
    func toDomain() -> AuthUser {
        AuthUser(id: id, email: email, token: token)
    }
}
