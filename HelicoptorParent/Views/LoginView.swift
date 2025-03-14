//
//  LoginView.swift
//  HeliParent
//
//  Created by Jacob on 3/13/25.
//

import SwiftUI

struct LoginView: View {
    @State private var passcode = ""
    @State private var errorMessage: String?
    @State private var isAuthenticated: Bool = false
    
    var body: some View {
        VStack {
            Text("Enter Passcode")
            SecureField("Passcode", text: $passcode)
            if let error = errorMessage {
                Text(error).foregroundColor(.red)
            }
            Button("Login") {
                let keychain = KeychainHelper()
                if keychain.authenticateUser(passcode: passcode) {
                    // Navigate to main app
                    isAuthenticated = true
                } else {
                    errorMessage = "Incorrect Passcode"
                }
            }
        }
        .padding()
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color.teal)
        .fullScreenCover(isPresented: $isAuthenticated) {
            HomeView()
        }
    }
}

#Preview {
    LoginView()
}
