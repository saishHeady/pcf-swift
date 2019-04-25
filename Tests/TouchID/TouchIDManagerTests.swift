//
//  TouchIDManagerTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/25/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest

class TouchIDManagerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTouchIDAvailable() {
        let touchIDManager = FakeTouchIDAvailableManager()
        do {
            try XCTAssertTrue(touchIDManager.isAvailable())
        }
    }

    func testTouchIDNotAvailable() {
        let touchIDManager = FakeTouchIDNotAvailableManager()
        do {
            _ = try touchIDManager.isAvailable()
        } catch let error {
            XCTAssertNotNil(error)
        }
    }

    func testTouchIDSetPreferencesActive() {
        let touchIDManager = FakeTouchIDAvailableManager()
        touchIDManager.activate()
        XCTAssertTrue(touchIDManager.isActive)
    }

    func testTouchIDSetPreferencesInactive() {
        let touchIDManager = FakeTouchIDManagerSuccessfulAuth()
        touchIDManager.deactivate()
        XCTAssertFalse(touchIDManager.isActive)
    }

    func testTouchIDSuccessfulAuthentication() {
        let touchIDManager = FakeTouchIDManagerSuccessfulAuth()
        let exp = expectation(description: "Expecting Touch ID authentication result")

        touchIDManager.authenticate(forReason: "Reason") { (success, error) in
            XCTAssertTrue(success)
            XCTAssertNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testTouchIDUnsuccessfulAuthentication() {
        let touchIDManager = FakeTouchIDAvailableManager()
        let exp = expectation(description: "Expecting Touch ID authentication result")

        touchIDManager.authenticate(forReason: "Reason") { (success, error) in
            XCTAssertFalse(success)
            XCTAssertNotNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testTouchIDUnauthorizedAuthentication() {
        let touchIDManager = FakeTouchIDNotAvailableManager()
        let exp = expectation(description: "Expecting wishlist items")

        touchIDManager.authenticate(forReason: "Reason") { (success, error) in
            XCTAssertFalse(success)
            XCTAssertNotNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
