//
//  HomeViewModel.swift
//  mobile
//
//  Created by Assistant on 01.05.2026.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var items: [HomeItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadItems() {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                items = try await repository.fetchItems()
            } catch {
                errorMessage = "Ошибка загрузки данных"
            }
            isLoading = false
        }
    }
}
