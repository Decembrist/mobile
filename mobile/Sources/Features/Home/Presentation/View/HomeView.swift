//
//  HomeView.swift
//  mobile
//
//  Created by Assistant on 01.05.2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Text(errorMessage)
                            .foregroundColor(.red)
                        Button("Повторить") {
                            viewModel.loadItems()
                        }
                    }
                } else {
                    List(viewModel.items) { item in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.title)
                                .font(.headline)
                            Text(item.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Главная")
            .onAppear {
                viewModel.loadItems()
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(repository: MockHomeRepository()))
}

// MARK: - Mock for Preview

final class MockHomeRepository: HomeRepositoryProtocol {
    func fetchItems() async throws -> [HomeItem] {
        try await Task.sleep(nanoseconds: 500_000_000)
        return [
            HomeItem(id: "1", title: "Элемент 1", description: "Описание первого элемента"),
            HomeItem(id: "2", title: "Элемент 2", description: "Описание второго элемента"),
            HomeItem(id: "3", title: "Элемент 3", description: "Описание третьего элемента")
        ]
    }
}
