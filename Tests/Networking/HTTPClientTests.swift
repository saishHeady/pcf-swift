//
//  HTTPClientTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/19/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class HTTPClientTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testHTTPClientPerformRequest() {
        let client = FakeHTTPClient(jsonName: "SingleOrder")
        let request = HTTPRequest(method: .get,
                                  baseURL: URL(string: "http://test.api.io/")!,
                                  path: "test",
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: nil)
        let exp = expectation(description: "Expecting HTTP client response")

        client.perform(request: request, completion: { (response, error) in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            exp.fulfill()
        })

        waitForExpectations(timeout: 1, handler: nil)
    }

}
