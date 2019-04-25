//
//  StoreDataManagerTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 6/29/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class StoreDataManagerTests: BaseTestDataManager {

    func testStoresValidResponse() {
        let validResponseClient = FakeHTTPClient(jsonName: "StoreCollection")
        let dataManager = StoreDataManager<PCFStore>(environmentManager: envManager,
                                                     sessionManager: sessionManager,
                                                     httpClient: validResponseClient,
                                                     decoder: JSONDecoder())

        let exp = expectation(description: "response expectation")
        dataManager.stores { (stores, error) in
            guard error == nil else {
                XCTFail("Expected valid response and no errors, got error: \(String(describing: error))")
                return
            }

            XCTAssertTrue(stores.count == 1)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testStoreValidResponse() {
        let validResponseClient = FakeHTTPClient(jsonName: "SingleStore")
        let dataManager = StoreDataManager<PCFStore>(environmentManager: envManager,
                                                     sessionManager: sessionManager,
                                                     httpClient: validResponseClient,
                                                     decoder: JSONDecoder())

        let exp = expectation(description: "response expectation")

        dataManager.store(forStoreId: "12345") { (store, error) in
            guard error == nil else {
                XCTFail("Expected valid response and no errors, got error: \(String(describing: error))")
                return
            }

            XCTAssertNotNil(store)
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
