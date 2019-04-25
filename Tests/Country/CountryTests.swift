//
//  CountryTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/21/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class CountryTests: XCTestCase {

    var country: PCFCountry!

    override func setUp() {
        super.setUp()

        do {
            let countryJSONData = try TestServer.getJSONData("SingleCountry")
            country = try JSONDecoder().decode(PCFCountry.self, from: countryJSONData)
        } catch {
            XCTFail("Couldn't open SingleCountry JSON file")
        }
    }

    override func tearDown() {
        country = nil
        super.tearDown()
    }

    func testCountry() {
        XCTAssertEqual(country.resourceId, "US")
        XCTAssertEqual(country.name, "United States")
    }

}
