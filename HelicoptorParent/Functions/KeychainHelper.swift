//
//  KeychainHelper.swift
//  HeliParent
//
//  Created by Jacob on 3/13/25.
//

import Security
import SwiftUI

class KeychainHelper {
    private let passcodeKey = "parent_passcode"
    
    func savePasscode(_ passcode: String) {
        let data = Data(passcode.utf8)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: passcodeKey,
            kSecValueData as String: data
        ]
        
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func getPasscode() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: passcodeKey,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func authenticateUser(passcode: String) -> Bool {
        return passcode == getPasscode()
    }
}
