//
//  Account+Locksmith.swift
//  PCFSwift
//
//  Created by Thibault Klein on 5/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Locksmith

private struct KeychainConstants {

    static let service = "PCF"
    static let userAccount = "PCFAccount"

    static let emailKey = "email"
    static let passwordKey = "password"
}

struct KeychainAccount: Account, CreateableSecureStorable, GenericPasswordSecureStorable {

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

    public init() { }

    public func account() -> Account? {
        let accountDictionary = Locksmith.loadDataForUserAccount(userAccount: KeychainConstants.userAccount,
                                                                 inService: KeychainConstants.service)

        guard let email = accountDictionary?[KeychainConstants.emailKey] as? String,
            let password = accountDictionary?[KeychainConstants.passwordKey] as? String else {
                return nil
        }

        return PCFAccount(email: email, password: password)
    }

    public func saveAccount(account: Account) throws {
        let keychainAccount = KeychainAccount(account: account)
        try Locksmith.saveData(data: keychainAccount.data,
                               forUserAccount: KeychainConstants.userAccount,
                               inService: KeychainConstants.service)
    }

    public func removeAccount() throws {
        try Locksmith.deleteDataForUserAccount(userAccount: KeychainConstants.userAccount,
                                               inService: KeychainConstants.service)
    }

}
