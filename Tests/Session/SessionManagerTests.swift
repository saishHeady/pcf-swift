//
//  SessionManagerTests.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 3/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class SessionManagerTests: XCTestCase {

    var sessionManager: SessionManager!
    var environments: [FakeHTTPEnvironment]!
    var envManager: FakeHTTPEnvironmentManager!
    var userDefaults: FakeUserDefaults!

    override func setUp() {
        super.setUp()

        environments = [FakeHTTPEnvironment(name: "QA", baseURL: URL(string: "http://qa.api.io")!)]
        envManager = FakeHTTPEnvironmentManager(environments: environments, initialEnvironment: environments.first!)
        userDefaults = FakeUserDefaults()

        let sessionIdClient = FakeHTTPClient(jsonName: "SessionID")
        sessionManager = FakeSessionManager(httpClient: sessionIdClient,
                                            environmentManager: envManager,
                                            persistenceClient: userDefaults)
    }

    override func tearDown() {
        environments = nil
        envManager = nil
        sessionManager = nil
        userDefaults = nil
        super.tearDown()
    }

    func test_ValidSessionId_IsPersistedInUserDefaults() {
        let exp = expectation(description: "response expectation")

        sessionManager.retrieveSessionIdentifier { (_) in
            //Then
            XCTAssertTrue(self.userDefaults.valueWasPersisted, "Expected the persistence client to save session id")
            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testSessionManagerErrorChecking_whenErrorIsSessionError() {
        let error = PCFError(code: 1002, message: "An active session is required for this endpoint.")
        let result = sessionManager.isSessionError(error: error)

        XCTAssertTrue(result)
    }

    func testSessionManagerErrorChecking_whenErrorIsRegularError() {
        let error = PCFError(code: 1, message: "")
        let result = sessionManager.isSessionError(error: error)

        XCTAssertFalse(result)
    }

    func testSessionManagerErrorChecking_whenErrorIsSwiftError() {
        let error: Swift.Error = TestError.jsonFileNotFound(filePath: "")
        let result = sessionManager.isSessionError(error: error)

        XCTAssertFalse(result)
    }

}
