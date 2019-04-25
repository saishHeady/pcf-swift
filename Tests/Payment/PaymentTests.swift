//
//  PaymentTests.swift
//  PCFSwift
//
//  Created by Daniel Vancura on 11/21/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import PCFSwift
import XCTest

class PaymentTests: XCTestCase {

    var paymentMethod: PCFPaymentMethod!

    override func setUp() {
        super.setUp()
        do {
            let orderJSONData = try TestServer.getJSONData("SinglePaymentMethod")
            paymentMethod = try JSONDecoder().decode(PCFPaymentMethod.self, from: orderJSONData)
        } catch {
            XCTFail("Can't open Single Order JSON")
        }
    }

    override func tearDown() {
        paymentMethod = nil
        super.tearDown()
    }

    func testPaymentMethod() {
        XCTAssertEqual(paymentMethod.resourceId, "12345")
        XCTAssertEqual(paymentMethod.type, "card")
        XCTAssertNotNil(paymentMethod.paymentObject)
    }

    func testPaymentObject() {
        let object = paymentMethod.paymentObject
        XCTAssertEqual(object.cardType, "Visa")
        XCTAssertEqual(object.number, "************1111")
        XCTAssertEqual(object.nameOnCard, "John Snow")
        XCTAssertEqual(object.expirationMonth, 1)
        XCTAssertEqual(object.expirationYear, 2020)
    }

}
