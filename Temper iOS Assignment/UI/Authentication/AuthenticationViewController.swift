//
//  AuthenticationViewController.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import SwiftUI

class AuthenticationViewController: UIHostingController<AuthenticationView> {
    init(type: AuthenticationType) {
        super.init(rootView: AuthenticationView(type: type))
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
