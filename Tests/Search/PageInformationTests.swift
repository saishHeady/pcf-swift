//
//  PageInformationTests.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 4/30/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class PageInformationTests: XCTestCase {

    func test_PageInformation_Equality() {
        let pageInformation = PageInformation(offset: 50, limit: 50)

        var testPageInformation = PageInformation(offset: 50, limit: 50)
        XCTAssertEqual(pageInformation, testPageInformation)

        testPageInformation = PageInformation(offset: 0, limit: 50)
        XCTAssertNotEqual(pageInformation, testPageInformation)
    }

}
