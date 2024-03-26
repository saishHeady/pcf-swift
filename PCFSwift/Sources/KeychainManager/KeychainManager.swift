//
//  Account+Locksmith.swift
//  PCFSwift
//
//  Created by Thibault Klein on 5/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import KeychainAccess

private struct KeychainConstants {

    static let service = "PCF"
    static let userAccount = "PCFAccount"

    static let emailKey = "email"
    static let passwordKey = "password"
}

struct KeychainAccount: Account {

    let email: String
    let password: String

    init(account: Account) {
        self.email = account.email
        self.password = account.password
    }

    let service: String = KeychainConstants.service

    var account: String {
        return email
    }

    var data: [String : Any] {
        return [KeychainConstants.emailKey: email, KeychainConstants.passwordKey: password]
    }

}

/// Keychain manager.
public struct KeychainManager: KeychainManageable {

    private let keychain: Keychain
    
    public init() { 
        self.keychain = .init(service: KeychainConstants.service).synchronizable(true)
    }

    public func account() -> Account? {
//        let accountDictionary = Locksmith.loadDataForUserAccount(userAccount: KeychainConstants.userAccount,
//                                                                 inService: KeychainConstants.service)
        
        if let account = try? keychain.getString(KeychainConstants.userAccount) {
            do {
                let accountData = Data(account.utf8)
                let decoder = JSONDecoder()
                
                return try decoder.decode(PCFAccount.self, from: accountData)
            } catch {
                debugPrint(error)
                return nil
            }
        } else {
            return nil
        }
    }

    public func saveAccount(account: Account) throws {
        let keychainAccount = KeychainAccount(account: account)
//        try Locksmith.saveData(data: keychainAccount.data,
//                               forUserAccount: KeychainConstants.userAccount,
//                               inService: KeychainConstants.service)
        let pcfAccount: PCFAccount = .init(email: account.email, password: account.password)
        
        let data = try JSONEncoder().encode(pcfAccount)
        let jsonString = String(data: data, encoding: .utf8) ?? .init()
        try? keychain.set(jsonString, key: KeychainConstants.userAccount)
    }

    public func removeAccount() throws {
//        try Locksmith.deleteDataForUserAccount(userAccount: KeychainConstants.userAccount,
//                                               inService: KeychainConstants.service)
        try? keychain.removeAll()
    }

}
