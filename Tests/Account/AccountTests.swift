//
//  AccountTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 5/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class AccountTests: XCTestCase {

    let manager = KeychainManager()

    override func setUp() {
        super.setUp()

        try? manager.removeAccount()
    }

    func testAccountCreation() {
        // Given
        let email = "thibault@prolificinteractive.com"
        let password = "ILovePCF"
        let account = PCFAccount(email: email, password: password)

        // Then
        XCTAssertEqual(account.email, email)
        XCTAssertEqual(account.password, password)
    }

    func testKeychainAccountCreation() {
        // When
        let email = "thibault@prolificinteractive.com"
        let password = "ILovePCF"
        let account = PCFAccount(email: email, password: password)
        let keychainAccount = KeychainAccount(account: account)
        let data = keychainAccount.data

        // Then
        XCTAssertEqual(keychainAccount.account, email)
        XCTAssertEqual(data["email"] as? String, email)
        XCTAssertEqual(data["password"] as? String, password)
    }

    func testKeychainManagerGetAccount() {
        // When
        let manager = KeychainManager()
        let account = manager.account()

        // Then
        XCTAssertNil(account)
    }

    func testKeychainManagerSaveAccount() {
        // When
        let manager = KeychainManager()
        let email = "thibault@prolificinteractive.com"
        let password = "ILovePCF"
        let account = PCFAccount(email: email, password: password)

        // Then
        do {
            try manager.saveAccount(account: account)
            XCTAssertTrue(true)
        } catch let error {
            XCTFail("Something happened with keychain manager save account: \(error.localizedDescription)")
        }
    }

    func testKeychainManagerRemoveAccount() {
        // When
        let manager = KeychainManager()
        let email = "thibault@prolificinteractive.com"
        let password = "ILovePCF"
        let account = PCFAccount(email: email, password: password)

        // Then
        do {
            try manager.saveAccount(account: account)
            try manager.removeAccount()
            XCTAssertTrue(true)
        } catch let error {
            XCTFail("Something happened with keychain manager save account: \(error.localizedDescription)")
        }
    }

}
