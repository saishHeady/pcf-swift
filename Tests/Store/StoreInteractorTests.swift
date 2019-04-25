//
//  StoreInteractorTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 6/29/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class StoreInteractorTests: BaseTestDataManager {

    private var dataManager: StoreDataManager<PCFStore>!
    private var stores: [PCFStore] = []

    override func setUp() {
        super.setUp()

        do {
            let storesJSONData = try TestServer.getJSONData("StoreCollection")
            stores = try JSONDecoder().decode([PCFStore].self, from: storesJSONData)
        } catch {
            XCTFail("Can't open Stores JSON")
        }

        dataManager = StoreDataManager<PCFStore>(environmentManager: envManager,
                                                 sessionManager: sessionManager,
                                                 httpClient: FakeHTTPClient(jsonName: "StoreCollection"),
                                                 decoder: JSONDecoder())
    }

    override func tearDown() {
        dataManager = nil
        stores = []

        super.tearDown()
    }

    func testGetStores() {
        let interactor = StoreInteractor(dataManager: dataManager)
        let exp = expectation(description: "testGetStores")

        interactor.stores { (stores, error) in
            XCTAssertFalse(stores.isEmpty)
            XCTAssertNil(error)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGetStore() {
        let dataManager = StoreDataManager<PCFStore>(environmentManager: envManager,
                                                     sessionManager: sessionManager,
                                                     httpClient: FakeHTTPClient(jsonName: "SingleStore"),
                                                     decoder: JSONDecoder())
        let interactor = StoreInteractor(dataManager: dataManager)
        let exp = expectation(description: "testGetStore")

        interactor.store(forStoreId: "1234") { (store, error) in
            XCTAssertNotNil(store)
            XCTAssertNil(error)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

}
