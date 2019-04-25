//
//  KeychainManageable.swift
//  PCFSwift
//
//  Created by Thibault Klein on 5/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Keychain manager protocol.
public protocol KeychainManageable {

    /// Retrieves the account from the keychain.
    ///
    /// - Returns: The account.
    func account() -> Account?

    /// Saves the given account to the keychain.
    ///
    /// - Parameter account: The account to save.
    /// - Throws: Error that could occur when saving to the keychain.
    func saveAccount(account: Account) throws

    /// Removes the account from the keychain.
    ///
    /// - Throws: Error that could occur when removing from the keychain.
    func removeAccount() throws

}
