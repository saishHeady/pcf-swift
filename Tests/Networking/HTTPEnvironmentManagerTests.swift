//
//  HTTPEnvironmentManagerTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/25/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class HTTPEnvironmentManagerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testEnvironmentManagerAddEnvironment() {
        let initialEnvironment = FakeHTTPEnvironment(name: "QA", baseURL: URL(string: "http://qa.api.io")!)
        let environments = [
            FakeHTTPEnvironment(name: "QA", baseURL: URL(string: "http://qa.api.io")!),
            FakeHTTPEnvironment(name: "Staging", baseURL: URL(string: "http://staging.api.io")!),
            FakeHTTPEnvironment(name: "Production", baseURL: URL(string: "http://production.api.io")!)
        ]
        let environmentManager = FakeHTTPEnvironmentManager(environments: environments,
                                                            initialEnvironment: initialEnvironment)

        XCTAssertEqual(environmentManager.currentEnvironment.name, initialEnvironment.name)
        XCTAssertEqual(environmentManager.currentEnvironment.baseURL, initialEnvironment.baseURL)
        XCTAssertEqual(environmentManager.environments.count, environments.count)
    }

    func testUpdateCurrentEnvironment() {
        // Given
        let initialEnvironment = FakeHTTPEnvironment(name: "QA", baseURL: URL(string: "http://qa.api.io")!)
        let environments = [
            FakeHTTPEnvironment(name: "QA", baseURL: URL(string: "http://qa.api.io")!),
            FakeHTTPEnvironment(name: "Staging", baseURL: URL(string: "http://staging.api.io")!),
            FakeHTTPEnvironment(name: "Production", baseURL: URL(string: "http://production.api.io")!)
        ]
        let environmentManager = FakeHTTPEnvironmentManager(environments: environments,
                                                            initialEnvironment: initialEnvironment)
        let stagingEnvironment = environments[1]
        // When
        environmentManager.currentEnvironment = stagingEnvironment
        // Then
        XCTAssertEqual(environmentManager.currentEnvironment.name, stagingEnvironment.name)
        XCTAssertEqual(environmentManager.currentEnvironment.baseURL, stagingEnvironment.baseURL)
    }

}
