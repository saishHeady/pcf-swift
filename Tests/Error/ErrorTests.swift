//
//  ErrorTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/21/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class ErrorTests: XCTestCase {

    var error: PCFError!

    override func setUp() {
        super.setUp()

        do {
            let errorJSONData = try TestServer.getJSONData("SingleError")
            error = try JSONDecoder().decode(PCFError.self, from: errorJSONData)
        } catch {
            XCTFail("Couldn't load SingleError JSON file")
        }
    }

    override func tearDown() {
        error = nil

        super.tearDown()
    }

    func testError() {
        XCTAssertEqual(error.code, 1000)
        XCTAssertEqual(error.message, "You must be logged in.")
    }

    func testSessionRequiredError() {
        // Given
        let error = PCFError(code: 1002, message: "An active session is required for this endpoint.")
        // Then
        XCTAssertTrue(error.isSessionError())
    }

    func testSessionInvalidError() {
        // Given
        let error = PCFError(code: 12000, message: "The sessionId is invalid.")
        // Then
        XCTAssertTrue(error.isSessionError())
    }

    func testErrorLocalizedDescription() {
        // Given
        let error = PCFError(code: 12000, message: "The sessionId is invalid.")
        // When
        let expectedLocalizedDescription = "The sessionId is invalid."
        // Then
        XCTAssertEqual(error.localizedDescription, expectedLocalizedDescription)
    }

}
