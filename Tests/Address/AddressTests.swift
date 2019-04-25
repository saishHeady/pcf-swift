//
//  AddressTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/20/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class AddressTests: XCTestCase {

    var address: PCFAddress!

    override func setUp() {
        super.setUp()

        do {
            let addressJSONData = try TestServer.getJSONData("SingleAddress")
            address = try JSONDecoder().decode(PCFAddress.self, from: addressJSONData)
        } catch {
            XCTFail("Can't open SingleAddress JSON")
        }
    }

    override func tearDown() {
        address = nil
        super.tearDown()
    }

    func testAddress() {
        XCTAssertEqual(address.resourceId, "1234")
        XCTAssertEqual(address.firstName, "James")
        XCTAssertEqual(address.lastName, "Bond")
        XCTAssertEqual(address.address1, "10001 Johnson St")
        XCTAssertNil(address.address2)
        XCTAssertEqual(address.city, "Novato")
        XCTAssertEqual(address.state, "CA")
        XCTAssertEqual(address.country, "US")
        XCTAssertEqual(address.zip, "94949")
        XCTAssertEqual(address.phone, "4151515555")
        XCTAssertTrue(address.save)
        XCTAssertFalse(address.isPrimary)
    }

}
