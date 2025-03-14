//
//  SetupView.swift
//  HeliParent
//
//  Created by Jacob on 3/13/25.
//

import SwiftUI
import LocalAuthentication

struct SetupView: View {
    @State private var passcode: String = ""
    @State private var confirmPasscode: String = ""
    @State private var isConfirming: Bool = false
    @State private var errorMessage: String?
    @State private var isAuthenticated: Bool = false
    
    var body: some View {
        VStack {
            Text(isConfirming ? "Confirm Passcode" : "Set Passcode")
            
            SecureField("Enter Passcode", text: $passcode)
            
            if isConfirming {
                SecureField("Confirm Passcode", text: $confirmPasscode)
            }
            
            if let error = errorMessage {
                Text(error).foregroundColor(.red)
            }
            
            Button("Next") {
                if isConfirming {
                    if passcode == confirmPasscode {
                        savePasscode(passcode)
                    } else {
                        errorMessage = "Passcodes do not match"
                    }
                } else {
                    isConfirming = true
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
    
    func savePasscode(_ passcode: String) {
        let keychain = KeychainHelper()
        keychain.savePasscode(passcode)
        isAuthenticated = true
    }
}

#Preview {
    SetupView()
}
