//
//  NavigationDataManagerRequestTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/4/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class NavigationDataManagerRequestTests: BaseTestDataManager {

    func testNavigationRequest() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = NavigationDataManager<PCFCategory>(environmentManager: envManager,
                                                             sessionManager: sessionManager,
                                                             httpClient: validResponseClient,
                                                             decoder: JSONDecoder())
        let path = "/categories"
        let request = dataManager.getRequest()
        let headers = dataManager.headers(forEnvironment: envManager.currentEnvironment)
        // When
        let expectedRequest = HTTPRequest(method: .get,
                                          baseURL: envManager.currentEnvironment.baseURL,
                                          path: path,
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
