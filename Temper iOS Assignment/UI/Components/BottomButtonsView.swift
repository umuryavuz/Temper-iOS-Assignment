//
//  BottomButtonsView.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 30/09/2023.
//

import SwiftUI

struct BottomButtonsView: View {
    
    let action: (AuthenticationType) -> ()
    
    private enum ButtonType: String {
        case login = "Log in"
        case signUp = "Sign up"
        
        var type: AuthenticationType {
            switch self {
            case .login:
                .login
            case .signUp:
                .signUp
            }
        }
        
        var color: Color {
            switch self {
            case .login:
                    .white
            case .signUp:
                    .green
            }
        }
    }
    var body: some View {
        HStack(spacing: 30) {
            button(.signUp)
            button(.login)
        }
        .padding(.top, 15)
        .padding(.horizontal, 15)
        .padding(.bottom, bottomSafeAreaHeight)
        .background(Color.white
            .cornerRadius(16, corners: [.topLeft, .topRight])
            .shadow(color: .gray.opacity(0.5), radius: 15, y: -10))
       
    }
    
    @ViewBuilder
    private func button(_ type: ButtonType) -> some View {
        Button(action: { action(type.type) }, label: {
            Text(type.rawValue)
                .bold()
                .font(.subheadline)
                .frame(maxWidth: .infinity, maxHeight: 40)
        })
        .foregroundColor(.black)
        .cardBackground(border: type == .login ,cornerRadius: 8, fillColor: type.color,shadowConfiguration: nil)
    }
}

#Preview {
    BottomButtonsView(action: { _ in })
}
