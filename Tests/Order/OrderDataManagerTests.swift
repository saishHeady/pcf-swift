//
//  OrderDataManagerTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class OrderDataManagerTests: BaseTestDataManager {

    func testOrdersValidResponse() {
        let validResponseClient = FakeHTTPClient(jsonName: "TestOrders")
        let dataManager = OrderDataManager<PCFOrder, PCFOrderDetail>(environmentManager: envManager,
                                                                     sessionManager: sessionManager,
                                                                     httpClient: validResponseClient,
                                                                     decoder: JSONDecoder())
        let exp = expectation(description: "response expectation")

        dataManager.orders { (orders, error) in
            XCTAssertFalse(orders.isEmpty)
            XCTAssertNil(error)

            guard let order = orders.first else {
                XCTFail("Error in \(#function)")
                return
            }

            XCTAssertEqual(order.resourceId, "123456")
            XCTAssertEqual(order.itemCount, 1)
            XCTAssertEqual(order.itemTotalCount, 5)
            XCTAssertEqual(order.subTotal, 299.99)
            XCTAssertEqual(order.tax, 9.88)
            XCTAssertEqual(order.totalAdjustment, -100)
            XCTAssertEqual(order.total, 199.99)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testGetOrderValidResponse() {
        let validResponseClient = FakeHTTPClient(jsonName: "SingleOrderDetail")
        let dataManager = OrderDataManager<PCFOrder, PCFOrderDetail>(environmentManager: envManager,
                                                                     sessionManager: sessionManager,
                                                                     httpClient: validResponseClient,
                                                                     decoder: JSONDecoder())
        let exp = expectation(description: "response expectation")

        dataManager.orderDetail(forOrderId: "") { (order, error) in
            XCTAssertNotNil(order)
            XCTAssertNil(error)

            guard order != nil else {
                XCTFail("Error in \(#function)")
                return
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testInvalidResponse() {
        let invalidResponseClient = FakeHTTPClient(jsonName: "SingleError")
        let dataManager = OrderDataManager<PCFOrder, PCFOrderDetail>(environmentManager: envManager,
                                                                     sessionManager: sessionManager,
                                                                     httpClient: invalidResponseClient,
                                                                     decoder: JSONDecoder())

        let exp = expectation(description: "response expectation")
        dataManager.orders { (_, error) in
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
