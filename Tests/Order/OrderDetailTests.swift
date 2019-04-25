//
//  OrderDetailTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 3/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class OrderDetailTests: XCTestCase {

    var order: PCFOrderDetail!

    override func setUp() {
        super.setUp()

        do {
            let orderJSONData = try TestServer.getJSONData("SingleOrderDetail")
            order = try JSONDecoder().decode(PCFOrderDetail.self, from: orderJSONData)
        } catch {
            XCTFail("Can't open Single Order JSON")
        }
    }

    override func tearDown() {
        order = nil

        super.tearDown()
    }

    func testOrderDetailDetail() {
        XCTAssertEqual(order.resourceId, "123456")
        XCTAssertEqual(order.itemCount, 1)
        XCTAssertEqual(order.itemTotalCount, 5)
        XCTAssertEqual(order.subTotal, 299.99)
        XCTAssertEqual(order.tax, 9.88)
        XCTAssertEqual(order.totalAdjustment, -100)
        XCTAssertEqual(order.total, 199.99)
    }

    func testOrderDetailItems() {
        XCTAssertTrue(order.items.count > 0)
    }

    func testOrderDetailDates() {
        let dateFormatter = PCFDateFormatter.sharedInstance
        dateFormatter.dateFormat = PCFOrderDetail.dateFormat
        let expectedOrderDate = dateFormatter.date(from: "1997-07-16T19:20:30+01:00")
        let expectedLastUpdatedDate = dateFormatter.date(from: "1997-07-16T19:20:30+01:00")

        XCTAssertEqual(order.orderDate, expectedOrderDate)
        XCTAssertEqual(order.lastUpdated, expectedLastUpdatedDate)
    }

    func testOrderDetailStatus() {
        XCTAssertEqual(order.status!.statusText, "shipped")
        XCTAssertEqual(order.status!.trackingNumber, "123456")
        XCTAssertTrue(order.status!.deliveryDate.count == 2)
    }

    func testOrderDetailStatusDeliveryDate() {
        // Given
        let statusDate1 = order.status!.deliveryDate[0]
        let statusDate2 = order.status!.deliveryDate[1]

        // When
        let dateFormatter = PCFDateFormatter.sharedInstance
        dateFormatter.dateFormat = "yyyy-MM-DD"
        let expectedDate1 = dateFormatter.date(from: "2014-07-16")
        let expectedDate2 = dateFormatter.date(from: "2014-07-19")

        // Then
        XCTAssertEqual(statusDate1, expectedDate1)
        XCTAssertEqual(statusDate2, expectedDate2)
    }

    func testOrderDetailBillingAddress() {
        XCTAssertNotNil(order.billingAddress)
    }

    func testOrderDetailShipments() {
        XCTAssertTrue(order.shipments.count > 0)
    }

    func testOrderDetailPaymentMethods() {
        XCTAssertTrue(order.paymentMethods.count > 0)
    }

    func testOrderDetailAdjustments() {
        XCTAssertTrue(order.adjustments.count == 1)
    }

}
