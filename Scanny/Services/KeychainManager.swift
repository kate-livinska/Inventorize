//
//  KeychainManager.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 15/01/2024.
//

import Foundation

class KeychainManager {
    enum KeychainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }
    
    static func saveToKeychain(key: String, password: String) {
        let passwordAsData = password.data(using: .utf8) ?? Data()
        do {
            try save(
                service: K.Keychain.service,
                account: key,
                password: passwordAsData)
            print("Password \(password) saved to keychain.")
        } catch {
            print(error.localizedDescription)
        }
        
        func save(
            service: String,
            account: String,
            password: Data
        ) throws {
            let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service as AnyObject,
                kSecAttrAccount as String: account as AnyObject,
                kSecValueData as String: password as AnyObject
            ]
            
            let status = SecItemAdd(query as CFDictionary, nil)
            
            guard status != errSecDuplicateItem else {
                throw KeychainManager.KeychainError.duplicateEntry
            }
            
            guard status == errSecSuccess else {
                throw KeychainManager.KeychainError.unknown(status)
            }
        }
    }
    
    static func getToken() -> String? {
        guard let data = get(
            service: K.Keychain.service,
            account: K.Keychain.tokenKey
        ) else {
            return nil
        }
        
        let token = String(decoding: data, as: UTF8.self)
        print(token)
        return token
        
        func get(
            service: String,
            account: String
        ) -> Data? {
            let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service as AnyObject,
                kSecAttrAccount as String: account as AnyObject,
                kSecReturnData as String: kCFBooleanTrue,
                kSecMatchLimit as String: kSecMatchLimitOne
            ]
            
            var result: AnyObject?
            let status = SecItemCopyMatching(query as CFDictionary, &result)
            print("KeychainM.get status: \(status)")
            print("Returning result of KeychainM.get")
            return result as? Data
        }
    }
    
    static func deleteToken() throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: K.Keychain.tokenKey
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainManager.KeychainError.unknown(status)
        }
        
        if status == errSecSuccess {
            print("Delete successful")
        }
    }
}
