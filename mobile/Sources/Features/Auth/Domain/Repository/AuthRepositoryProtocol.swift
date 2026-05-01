//
//  AuthRepositoryProtocol.swift
//  mobile
//
//  Created by Assistant on 01.05.2026.
//

import Foundation

protocol AuthRepositoryProtocol {
    func login(email: String, password: String) async throws -> AuthUser
    func logout() async throws
    func getCurrentUser() async throws -> AuthUser?
}
