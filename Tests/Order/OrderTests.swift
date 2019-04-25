//
//  OrderTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/19/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class OrderTests: XCTestCase {

    var order: PCFOrder!

    override func setUp() {
        super.setUp()

        do {
            let orderJSONData = try TestServer.getJSONData("SingleOrder")
            order = try JSONDecoder().decode(PCFOrder.self, from: orderJSONData)
        } catch {
            XCTFail("Can't open Single Order JSON")
        }
    }

    override func tearDown() {
        order = nil

        super.tearDown()
    }

    func testOrder() {
        XCTAssertEqual(order.resourceId, "123456")
        XCTAssertEqual(order.itemCount, 1)
        XCTAssertEqual(order.itemTotalCount, 5)
        XCTAssertEqual(order.subTotal, 299.99)
        XCTAssertEqual(order.tax, 9.88)
        XCTAssertEqual(order.totalAdjustment, -100)
        XCTAssertEqual(order.total, 199.99)
    }

    func testOrderDates() {
        let dateFormatter = PCFDateFormatter.sharedInstance
        dateFormatter.dateFormat = dateFormat
        let expectedOrderDate = dateFormatter.date(from: "1997-07-16T19:20:30+01:00")
        let expectedLastUpdatedDate = dateFormatter.date(from: "1997-07-16T19:20:30+01:00")

        XCTAssertEqual(order.orderDate, expectedOrderDate)
        XCTAssertEqual(order.lastUpdated, expectedLastUpdatedDate)
    }

    func testOrderStatus() {
        XCTAssertEqual(order.status.statusText, "shipped")
        XCTAssertEqual(order.status.trackingNumber, "123456")
        XCTAssertTrue(order.status.deliveryDate.count == 2)
    }

    func testOrderStatusDeliveryDate() {
        // Given
        let statusDate1 = order.status.deliveryDate[0]
        let statusDate2 = order.status.deliveryDate[1]

        // When
        let dateFormatter = PCFDateFormatter.sharedInstance
        dateFormatter.dateFormat = "yyyy-MM-DD"
        let expectedDate1 = dateFormatter.date(from: "2014-07-16")
        let expectedDate2 = dateFormatter.date(from: "2014-07-19")

        // Then
        XCTAssertEqual(statusDate1, expectedDate1)
        XCTAssertEqual(statusDate2, expectedDate2)
    }

}
