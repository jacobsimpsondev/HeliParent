//
//  ContentView.swift
//  HelicoptorParent
//
//  Created by Jacob on 3/12/25.
//

import SwiftUI

struct ContentView: View {
    let keychain = KeychainHelper()
    
    var body: some View {
        if keychain.getPasscode() == nil {
            SetupView() // First-time users set a passcode
        } else {
            LoginView() // Returning users authenticate
        }
    }
}

#Preview {
    ContentView()
}
