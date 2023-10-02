//
//  AuthenticationView.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import SwiftUI

struct AuthenticationView: View {
    let type: AuthenticationType
    var body: some View {
        switch type {
        case .login:
            Text("Login View")
        case .signUp:
            Text("Sign Up View")
        }
      
    }
}

#Preview("Login") {
    AuthenticationView(type: .login)
}
#Preview("SignUp") {
    AuthenticationView(type: .signUp)
}

