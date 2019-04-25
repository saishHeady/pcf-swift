//
//  CartShipmentTests.swift
//  PCFSwift
//
//  Created by Harlan Kellaway on 9/26/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import XCTest
@testable import PCFSwift

class CartShipmentTests: XCTestCase {

    var cartShipment: PCFCartShipment!

    // MARK: - Test Case Life Cycle
    override func setUp() {
        super.setUp()

        do {
            let cartShipmentJSONData = try TestServer.getJSONData("CartShipment")
            cartShipment = try JSONDecoder().decode(PCFCartShipment.self, from: cartShipmentJSONData)
        } catch {
            XCTFail("Can't open CartShipment JSON")
        }
    }

    override func tearDown() {
        cartShipment = nil
        super.tearDown()
    }

    // MARK: - CartShipment
    func testCartShipment() {
        XCTAssertEqual(cartShipment.resourceId, "1234")
        XCTAssertNotNil(cartShipment.shippingAddress)
        XCTAssertNotNil(cartShipment.shippingOption)
    }

    func testCartShipmentAddress() {
        // Given
        let shippingAddress = cartShipment.shippingAddress
        // Then
        XCTAssertEqual(shippingAddress?.address1, "10001 Johnson St")
        XCTAssertNil(shippingAddress?.address2)
        XCTAssertEqual(shippingAddress?.city, "Novato")
        XCTAssertEqual(shippingAddress?.country, "US")
        XCTAssertEqual(shippingAddress?.firstName, "James")
        XCTAssertEqual(shippingAddress?.isPrimary, false)
        XCTAssertEqual(shippingAddress?.lastName, "Bond")
        XCTAssertEqual(shippingAddress?.phone, "4151515555")
        XCTAssertEqual(shippingAddress?.resourceId, "1234")
        XCTAssertEqual(shippingAddress?.save, true)
        XCTAssertEqual(shippingAddress?.state, "CA")
        XCTAssertEqual(shippingAddress?.zip, "94949")
    }

    func testCartShipmentOption() {
        // Given
        let shippingOption = cartShipment.shippingOption
        // Then
        XCTAssertEqual(shippingOption?.name, "standard (4-5 days)")
        XCTAssertEqual(shippingOption?.price, 10.0)
        XCTAssertEqual(shippingOption?.resourceId, "1")
    }

}
