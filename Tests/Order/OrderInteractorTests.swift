//
//  OrderInteractorTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class OrderInteractorTests: BaseTestDataManager {

    private var dataManager: OrderDataManager<PCFOrder, PCFOrderDetail>!
    private var orders: [PCFOrder] = []

    override func setUp() {
        super.setUp()

        do {
            let ordersJSONData = try TestServer.getJSONData("TestOrders")
            orders = try JSONDecoder().decode([PCFOrder].self, from: ordersJSONData)
        } catch {
            XCTFail("Can't open Cart JSON")
        }

        dataManager = OrderDataManager<PCFOrder, PCFOrderDetail>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: FakeHTTPClient(jsonName: "TestOrders"),
                                                                 decoder: JSONDecoder())
    }

    override func tearDown() {
        dataManager = nil
        orders = []

        super.tearDown()
    }

    func testGetOrders() {
        let interactor = OrderInteractor<PCFOrder, PCFOrderDetail>(dataManager: dataManager)
        let exp = expectation(description: "testGetOrders")

        interactor.orders { (orders, error) in
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

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetOrder() {
        let validResponseClient = FakeHTTPClient(jsonName: "SingleOrderDetail")
        let dataManager = OrderDataManager<PCFOrder, PCFOrderDetail>(environmentManager: envManager,
                                                                     sessionManager: sessionManager,
                                                                     httpClient: validResponseClient,
                                                                     decoder: JSONDecoder())
        let interactor = OrderInteractor(dataManager: dataManager)
        let exp = expectation(description: "testGetOrder")

        interactor.orderDetail(forOrderId: "") { (order, error) in
            XCTAssertNotNil(order)
            XCTAssertNil(error)

            guard let order = order else {
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

            XCTAssertNotNil(order.billingAddress)

            XCTAssertTrue(order.shipments.count == 1)
            XCTAssertTrue(order.paymentMethods.count == 1)
            XCTAssertTrue(order.adjustments.count == 1)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

}
