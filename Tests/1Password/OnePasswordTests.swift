//
//  OnePasswordTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class OnePasswordTests: XCTestCase {

    func testOnePasswordUser() {
        let user = OnePasswordUser(email: "Bruce Wayne", password: "Gotham")
        XCTAssertEqual(user.email, "Bruce Wayne")
        XCTAssertEqual(user.password, "Gotham")
    }

    func testOnePasswordIsAvailable() {
        let manager = OnePasswordManager()

        XCTAssertFalse(manager.available)
    }

    func testOnePasswordButtonValid() {
        let manager = OnePasswordManager()

        do {
            let button = try manager.button()
            XCTAssertNotNil(button.imageView?.image)
        } catch _ {
            XCTFail("Error in \(#function)")
        }
    }

    func testOnePasswordFindLoginValid() {
        // Given
        let manager = FakeOnePasswordValidManager()
        let exp = expectation(description: "response expectation")

        // When
        let expectedUser = OnePasswordUser(email: "Bruce Wayne", password: "Gotham")

        // Then
        manager.findLogin(forURLString: "", viewController: UIViewController(), sender: nil) { (user, error) in
            XCTAssertEqual(user?.email, expectedUser.email)
            XCTAssertEqual(user?.password, expectedUser.password)

            XCTAssertNil(error)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testOnePasswordFindloginNotFound() {
        // Given
        let manager = FakeOnePasswordInvalidManager()
        let exp = expectation(description: "response expectation")

        // Then
        manager.findLogin(forURLString: "", viewController: UIViewController(), sender: nil) { (user, error) in
            XCTAssertNil(user)
            XCTAssertNotNil(error)
            XCTAssertEqual(error, CredentialsError.loginNotFound)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testCredentialsErrorImageNotFoundEqual() {
        let error1 = CredentialsError.imageBundleNotFound
        let error2 = CredentialsError.imageBundleNotFound

        XCTAssertEqual(error1, error2)
    }

    func testCredentialsErrorloginNotFoundEqual() {
        let error1 = CredentialsError.loginNotFound
        let error2 = CredentialsError.loginNotFound

        XCTAssertEqual(error1, error2)
    }

    func testCredentialsErroruserCancelledEqual() {
        let error1 = CredentialsError.userCancelled
        let error2 = CredentialsError.userCancelled

        XCTAssertEqual(error1, error2)
    }

}
