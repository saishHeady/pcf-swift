//
//  HTTPRequestTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/19/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class HTTPRequestTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testValidGETHTTPRequest_noPathNoQuery() {
        let request = HTTPRequest(method: .get,
                                  baseURL: URL(string: "http://test.api.io/")!,
                                  path: "",
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: nil)

        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.endpoint.absoluteString, "http://test.api.io/")
        XCTAssertNil(request.parameters)
        XCTAssertNil(request.headers)
    }

    func testValidGETHTTPRequest_withPathNoQuery() {
        let request = HTTPRequest(method: .get,
                                  baseURL: URL(string: "http://test.api.io/")!,
                                  path: "test",
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: nil)

        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.endpoint.absoluteString, "http://test.api.io/test")
        XCTAssertNil(request.parameters)
        XCTAssertNil(request.headers)
    }

    func testValidGETHTTPRequest_withPathAndSingleQueryItem() {
        let request = HTTPRequest(method: .get,
                                  baseURL: URL(string: "http://test.api.io/")!,
                                  path: "test",
                                  queryItems: ["firstName": "Jean"],
                                  parameters: nil,
                                  headers: nil)

        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.endpoint.absoluteString, "http://test.api.io/test?firstName=Jean")
        XCTAssertNil(request.parameters)
        XCTAssertNil(request.headers)
    }

    func testValidGETHTTPRequest_withPathAndMultipleQueryItems() {
        let request = HTTPRequest(method: .get,
                                  baseURL: URL(string: "http://test.api.io/")!,
                                  path: "test",
                                  queryItems: ["firstName": "Jean", "lastName": "Marc"],
                                  parameters: nil,
                                  headers: nil)

        XCTAssertEqual(request.method, .get)
        XCTAssertTrue(request.endpoint.absoluteString.contains("firstName=Jean"))
        XCTAssertTrue(request.endpoint.absoluteString.contains("lastName=Marc"))
        XCTAssertNil(request.parameters)
        XCTAssertNil(request.headers)
    }

    func testValidGETHTTPRequest_withPathAndMultipleQueryItemsContainingSpace() {
        let request = HTTPRequest(method: .get,
                                  baseURL: URL(string: "http://test.api.io/")!,
                                  path: "test",
                                  queryItems: ["firstName": "Jean", "lastName": "Marc Dutroux"],
                                  parameters: nil,
                                  headers: nil)

        XCTAssertEqual(request.method, .get)
        XCTAssertTrue(request.endpoint.absoluteString.contains("firstName=Jean"))
        XCTAssertTrue(request.endpoint.absoluteString.contains("lastName=Marc%20Dutroux"))
        XCTAssertNil(request.parameters)
        XCTAssertNil(request.headers)
    }

}
