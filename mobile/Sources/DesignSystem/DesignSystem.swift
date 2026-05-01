//
//  DesignSystem.swift
//  mobile
//
//  Created by Assistant on 01.05.2026.
//

import SwiftUI

// MARK: - Colors

enum AppColors {
    static let primary = Color.blue
    static let secondary = Color.gray
    static let error = Color.red
    static let success = Color.green
    static let background = Color(UIColor.systemBackground)
}

// MARK: - Fonts

enum AppFonts {
    static func title(_ size: CGFloat = 24) -> Font {
        .system(size: size, weight: .bold)
    }
    
    static func headline(_ size: CGFloat = 18) -> Font {
        .system(size: size, weight: .semibold)
    }
    
    static func body(_ size: CGFloat = 16) -> Font {
        .system(size: size, weight: .regular)
    }
    
    static func caption(_ size: CGFloat = 14) -> Font {
        .system(size: size, weight: .regular)
    }
}

// MARK: - Components

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var isLoading: Bool = false
    var isEnabled: Bool = true
    
    var body: some View {
        Button(action: action) {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text(title)
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(isEnabled && !isLoading ? AppColors.primary : AppColors.secondary)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .disabled(!isEnabled || isLoading)
    }
}

struct StyledTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    VStack(spacing: 16) {
        PrimaryButton(title: "Войти", action: {})
        
        StyledTextField(placeholder: "Email", text: .constant(""))
        
        StyledTextField(placeholder: "Пароль", text: .constant(""), isSecure: true)
    }
    .padding()
}
