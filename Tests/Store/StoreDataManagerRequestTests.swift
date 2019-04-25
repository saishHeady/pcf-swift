//
//  StoreDataManagerRequestTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 6/29/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class StoreDataManagerRequestTests: BaseTestDataManager {

    func testStorePath() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = StoreDataManager<PCFStore>(environmentManager: envManager,
                                                     sessionManager: sessionManager,
                                                     httpClient: validResponseClient,
                                                     decoder: JSONDecoder())
        let path = dataManager.storeRequestPath(forStoreId: "1234")
        // When
        let expectedPath = "/stores/1234"
        // Then
        XCTAssertEqual(path, expectedPath)
    }

    func testStoresRequest() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = StoreDataManager<PCFStore>(environmentManager: envManager,
                                                     sessionManager: sessionManager,
                                                     httpClient: validResponseClient,
                                                     decoder: JSONDecoder())
        let path = dataManager.storesRequestPath
        let request = dataManager.storeRequest(forPath: path)
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

    func testStoreRequest() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = StoreDataManager<PCFStore>(environmentManager: envManager,
                                                     sessionManager: sessionManager,
                                                     httpClient: validResponseClient,
                                                     decoder: JSONDecoder())
        let path = dataManager.storeRequestPath(forStoreId: "1234")
        let request = dataManager.storeRequest(forPath: path)
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
