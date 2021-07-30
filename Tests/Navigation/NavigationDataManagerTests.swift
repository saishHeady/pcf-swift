//
//  NavigationDataManagerTests.swift
//  PCFSwift
//
//  Created by Daniel Vancura on 3/7/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

private struct HTTPGetRequestCheck: HTTPClient {

    func perform(request: HTTPRequest, completion: @escaping (Any?, Swift.Error?) -> Void) {
        XCTAssertEqual(request.endpoint, URL(string: "http://qa.api.io/categories?parentCategoryId=1"))
        completion(nil, nil)
    }

}

internal final class NavigationDataManagerTests: BaseTestDataManager {

    /// Test for PCFCategoryDataManager.categories(completion: _)
    func testValidResponse() {
        let validResponseClient = FakeHTTPClient(jsonName: "SingleCategoryMap")
        let dataManager = NavigationDataManager<PCFCategory>(environmentManager: envManager,
                                                             sessionManager: sessionManager,
                                                             httpClient: validResponseClient,
                                                             decoder: JSONDecoder())

        let exp = expectation(description: "response expectation")
        dataManager.categories { (categories, error) in
            guard error == nil else {
                XCTFail("Expected valid response and no errors, got error: \(String(describing: error))")
                return
            }

            let responseCategoryIds = categories.compactMap { cat -> String? in
                cat.resourceId
            }

            XCTAssertEqual(categories.count, 4)
            XCTAssertTrue(Set(["1", "2", "3", "4"]).intersection(Set(responseCategoryIds)).count == 4)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    /// Test for URL passed in PCFCategoryDataManager.categories(parentCategory: _, completion: _)
    func testValidSubcategoryRequest() {
        let testClient = HTTPGetRequestCheck()
        let dataManager = NavigationDataManager<PCFCategory>(environmentManager: envManager,
                                                             sessionManager: sessionManager,
                                                             httpClient: testClient,
                                                             decoder: JSONDecoder())

        let exp = expectation(description: "response expectation")
        dataManager.categories(parentCategory: "1") { _, _ in
            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    /// Test for PCFCategoryDataManager.categories(completion: _), expecting an error.
    func testInvalidResponse() {
        let invalidResponseClient = FakeHTTPClient(jsonName: "SingleError")
        let dataManager = NavigationDataManager<PCFCategory>(environmentManager: envManager,
                                                             sessionManager: sessionManager,
                                                             httpClient: invalidResponseClient,
                                                             decoder: JSONDecoder())

        let exp = expectation(description: "response expectation")
        dataManager.categories { (_, error) in
            guard let error = error else {
                XCTFail("Expected an error")
                return
            }

            XCTAssertTrue(error is PCFError)
            XCTAssertEqual(error as? PCFError, PCFError.invalidJSON)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

}
