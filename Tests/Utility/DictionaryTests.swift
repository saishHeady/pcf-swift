//
//  DictionaryTests.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 3/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class DictionaryTests: XCTestCase {

    private var contentHeaders: Headers!

    func testDictionariesCanBeAdded() {
        //Given
        contentHeaders = ["Content-Type": "application/json; charset=utf-8"]
        let sessionHeaders = ["sessionId": "3452625f-ab39-4f63-9416-97bd1c8e108c"]

        //When
        let result = contentHeaders.combineWith(sessionHeaders)

        //Then
        XCTAssert(result.count == 2, "Expected a dictionary with 2 (key, value) pairs")
    }
}
