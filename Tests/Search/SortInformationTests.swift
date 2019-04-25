//
//  SortInformationTests.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 4/30/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class SortInformationTests: XCTestCase {

    func test_SortInformation_Equality() {
        let sortInformation = SortInformation(sort: "tops", order: "asc")

        var testSortInformation = SortInformation(sort: "tops", order: "asc")
        XCTAssertEqual(sortInformation, testSortInformation)

        testSortInformation = SortInformation(sort: "tops", order: "desc")
        XCTAssertNotEqual(sortInformation, testSortInformation)
    }

}
