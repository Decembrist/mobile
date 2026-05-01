//
//  AuthAPIProtocol.swift
//  mobile
//
//  Created by Assistant on 01.05.2026.
//

import Foundation

protocol AuthAPIProtocol {
    func login(email: String, password: String) async throws -> AuthResponseDTO
    func logout() async throws
}
