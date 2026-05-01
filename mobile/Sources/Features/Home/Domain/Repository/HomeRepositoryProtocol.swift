//
//  HomeRepositoryProtocol.swift
//  mobile
//
//  Created by Assistant on 01.05.2026.
//

import Foundation

protocol HomeRepositoryProtocol {
    func fetchItems() async throws -> [HomeItem]
}
