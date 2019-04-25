//
//  OrderDataManagerRequestTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class OrderDataManagerRequestTests: BaseTestDataManager {

    func testOrdersRequest() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = OrderDataManager<PCFOrder, PCFOrderDetail>(environmentManager: envManager,
                                                                     sessionManager: sessionManager,
                                                                     httpClient: validResponseClient,
                                                                     decoder: JSONDecoder())
        let request = dataManager.orderRequest(forPath: "/orders")
        let headers = dataManager.headers(forEnvironment: envManager.currentEnvironment)
        // When
        let expectedRequest = HTTPRequest(method: .get,
                                          baseURL: envManager.currentEnvironment.baseURL,
                                          path: "/orders",
                                          queryItems: nil,
                                          parameters: nil,
                                          headers: headers)
        // Then
        XCTAssertEqual(request.baseURL, expectedRequest.baseURL)
        XCTAssertEqual(request.method, expectedRequest.method)
        XCTAssertEqual(request.endpoint, expectedRequest.endpoint)
        XCTAssertEqual(request.path, expectedRequest.path)
        XCTAssertEqual(request.headers!, expectedRequest.headers!)
    }

}
