//
//  LoginView.swift
//  mobile
//
//  Created by Assistant on 01.05.2026.
//

import SwiftUI

struct LoginView: View {
    private let viewModel: AuthViewModel
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 24) {
            // Logo or Title
            Text("Вход")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Email Field
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            
            // Password Field
            SecureField("Пароль", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            
            // Error Message
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            // Login Button
            Button(action: {
                viewModel.login()
            }) {
                HStack {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Войти")
                            .fontWeight(.semibold)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.isLoading ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .disabled(viewModel.isLoading)
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        LoginView(viewModel: AuthViewModel(loginUseCase: MockLoginUseCase()))
    }
}

// MARK: - Mock for Preview

final class MockLoginUseCase: LoginUseCaseProtocol {
    func execute(input: LoginInput) async throws -> LoginOutput {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return LoginOutput(user: AuthUser(id: "1", email: input.email, token: "mock_token"))
    }
}
