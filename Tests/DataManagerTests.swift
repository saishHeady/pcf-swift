//
//  DataManagerTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest

@testable import PCFSwift

class DataManagerTests: XCTestCase {

    let environments = FakeHTTPEnvironmentManager.fakeEnvironments()
    var envManager: HTTPEnvironmentManager!
    var sessionManager: SessionManager!

    override func setUp() {
        super.setUp()

        envManager = FakeHTTPEnvironmentManager(environments: environments,
                                                initialEnvironment: environments.first!)
        sessionManager = FakeSessionManager(httpClient: FakeHTTPClient(),
                                            environmentManager: envManager,
                                            persistenceClient: FakeUserDefaults())
    }

    override func tearDown() {
        envManager = nil
        sessionManager = nil

        super.tearDown()
    }

    func testDataManagerReturningError() {
        let errorHTTPClient = FakeHTTPErrorClient(jsonName: "SingleError")
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: errorHTTPClient)
        let exp = expectation(description: "response expectation")

        dataManager.cart { (cart, error) in
            XCTAssertNil(cart)
            XCTAssertNotNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testDataManagerReturningSessionInvalidError() {
        let sessionManager = FakeInvalidSessionManager(httpClient: FakeHTTPClient(),
                                                       environmentManager: envManager,
                                                       persistenceClient: FakeUserDefaults())
        let errorHTTPClient = FakeHTTPErrorClient(jsonName: "SingleSessionInvalidError")
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: errorHTTPClient)
        let exp = expectation(description: "response expectation")

        dataManager.cart { (cart, error) in
            XCTAssertNil(cart)
            XCTAssertNotNil(error)

            exp.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testDataManagerReturningSessionMissingError() {
        let sessionManager = FakeInvalidSessionManager(httpClient: FakeHTTPClient(),
                                                       environmentManager: envManager,
                                                       persistenceClient: FakeUserDefaults())
        let errorHTTPClient = FakeHTTPErrorClient(jsonName: "SingleSessionMissingError")
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: errorHTTPClient)
        let exp = expectation(description: "response expectation")

        dataManager.cart { (cart, error) in
            XCTAssertNil(cart)
            XCTAssertNotNil(error)

            exp.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testDataManagerArrayReturningError() {
        let errorHTTPClient = FakeHTTPErrorClient(jsonName: "SingleError")
        let dataManager = NavigationDataManager<PCFCategory>(environmentManager: envManager,
                                                             sessionManager: sessionManager,
                                                             httpClient: errorHTTPClient,
                                                             decoder: JSONDecoder())

        let exp = expectation(description: "response expectation")
        dataManager.categories(parentCategory: "1") { (categories, error) in
            XCTAssertTrue(categories.isEmpty)
            XCTAssertNotNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testDataManagerArrayReturningSessionError() {
        let sessionManager = FakeInvalidSessionManager(httpClient: FakeHTTPClient(),
                                                       environmentManager: envManager,
                                                       persistenceClient: FakeUserDefaults())
        let errorHTTPClient = FakeHTTPErrorClient(jsonName: "SingleSessionMissingError")
        let dataManager = NavigationDataManager<PCFCategory>(environmentManager: envManager,
                                                             sessionManager: sessionManager,
                                                             httpClient: errorHTTPClient,
                                                             decoder: JSONDecoder())

        let exp = expectation(description: "response expectation")
        dataManager.categories(parentCategory: "1") { (categories, error) in
            XCTAssertTrue(categories.isEmpty)
            XCTAssertNotNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testDataManager_whenResetSessionWorks() {
        let dataManager = FakeDataManager(environmentManager: envManager,
                                          sessionManager: sessionManager,
                                          httpClient: FakeHTTPClient(),
                                          decoder: JSONDecoder())
        let request = HTTPRequest(method: .get,
                                  baseURL: envManager.currentEnvironment.baseURL,
                                  path: "",
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: nil)

        let exp = expectation(description: "response expectation")
        dataManager.perform(request: request) { (object: FakeGloss.DecodableObject?, error: Swift.Error?) in
            XCTAssertNotNil(object)
            XCTAssertNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testDataManagerArray_whenResetSessionWorks() {
        let httpClient = FakeHTTPClient(jsonName: "SingleCategoryMap")

        sessionManager = FakeSessionManager(httpClient: httpClient,
                                            environmentManager: envManager,
                                            persistenceClient: FakeUserDefaults())

        let dataManager = FakeDataManager(environmentManager: envManager,
                                          sessionManager: sessionManager,
                                          httpClient: httpClient,
                                          decoder: JSONDecoder())
        let request = HTTPRequest(method: .get,
                                  baseURL: envManager.currentEnvironment.baseURL,
                                  path: "",
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: nil)

        let exp = expectation(description: "response expectation")
        dataManager.perform(request: request) { (object: [FakeGloss.DecodableObject], error: Swift.Error?) in
            XCTAssertFalse(object.isEmpty)
            XCTAssertNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testDataManagerArray_whenResetSessionWorks_andReturnedTypeIsNotAnArray() {
        let dataManager = FakeDataManager(environmentManager: envManager,
                                          sessionManager: sessionManager,
                                          httpClient: FakeHTTPClient(),
                                          decoder: JSONDecoder())
        let request = HTTPRequest(method: .get,
                                  baseURL: envManager.currentEnvironment.baseURL,
                                  path: "",
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: nil)

        let exp = expectation(description: "response expectation")
        dataManager.perform(request: request) { (object: [FakeGloss.DecodableObject], error: Swift.Error?) in
            XCTAssertTrue(object.isEmpty)
            XCTAssertNotNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

}
