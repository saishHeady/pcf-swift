//
//  StoreTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 6/29/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class StoreTests: XCTestCase {

    var store: PCFStore!

    override func setUp() {
        super.setUp()

        do {
            let storeJSONData = try TestServer.getJSONData("SingleStore")
            store = try JSONDecoder().decode(PCFStore.self, from: storeJSONData)
        } catch {
            XCTFail("Can't open Store JSON")
        }
    }

    override func tearDown() {
        store = nil

        super.tearDown()
    }

    func testStore() {
        XCTAssertEqual(store.resourceId, "12345")
        XCTAssertEqual(store.name, "Store Name")
        XCTAssertEqual(store.address.resourceId, "1234")
        XCTAssertEqual(store.address.address1, "10001 Johnson St")
        XCTAssertEqual(store.address.city, "Novato")
        XCTAssertEqual(store.address.state, "CA")
        XCTAssertEqual(store.address.country, "US")
        XCTAssertEqual(store.address.zip, "94949")
        XCTAssertEqual(store.address.phone, "4151515555")
        XCTAssertEqual(store.description, "This is the best store")
        XCTAssertEqual(store.hours, "Mon - Sat 10:00am - 9:00pm|Sun 12:00pm - 6:00pm")
        XCTAssertEqual(store.coordinate.latitude, 39.975098)
        XCTAssertEqual(store.coordinate.longitude, -74.580881)
    }

}
