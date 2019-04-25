//
//  ProductDataManagerRequestTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/4/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class ProductDataManagerRequestTests: BaseTestDataManager {

    func testProductPath() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: validResponseClient,
                                                                 decoder: JSONDecoder())
        let path = dataManager.productRequestPath(forProductId: "1234")
        // When
        let expectedPath = "/products/1234"
        // Then
        XCTAssertEqual(path, expectedPath)
    }

    func testProductSKUPath() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: validResponseClient,
                                                                 decoder: JSONDecoder())
        let path = dataManager.skuRequestPath(forSkuId: "9876", productId: "1234")
        // When
        let expectedPath = "/products/1234/skus/9876"
        // Then
        XCTAssertEqual(path, expectedPath)
    }

    func testProductRequest() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: validResponseClient,
                                                                 decoder: JSONDecoder())
        let path = dataManager.productRequestPath(forProductId: "1234")
        let request = dataManager.getRequest(forPath: path)
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
