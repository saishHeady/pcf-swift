//
//  ProductDataManagerTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 3/21/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

private struct HTTPGetRequestCheck: HTTPClient {

    func perform(request: HTTPRequest, completion: @escaping (Any?, Swift.Error?) -> Void) {
        XCTAssertEqual(request.endpoint, URL(string: "http://qa.api.io/categories?parentCategoryId=1"))
        completion(nil, nil)
    }

}

class ProductDataManagerTests: BaseTestDataManager {

    func testProductValidResponse() {
        let validResponseClient = FakeHTTPClient(jsonName: "SingleProduct")
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: validResponseClient,
                                                                 decoder: JSONDecoder())

        let exp = expectation(description: "response expectation")
        dataManager.product(forProductId: "") { (product, error) in
            guard error == nil else {
                XCTFail("Expected valid response and no errors, got error: \(String(describing: error))")
                return
            }
            guard let product = product else {
                XCTFail("Expected valid response, got nil product")
                return
            }

            XCTAssertEqual(product.resourceId, "1234")
            XCTAssertEqual(product.name, "Vera")
            XCTAssertEqual(product.price, 45.0)
            XCTAssertEqual(product.discountedPrice, 40.0)
            XCTAssertEqual(product.productDescription, "<p>Gorgeous lace ...")
            XCTAssertNotNil(product.imageResources)
            XCTAssertTrue(product.imageIds.count == 2)
            XCTAssertEqual(product.imageIds[0], "1")
            XCTAssertEqual(product.imageIds[1], "2")
            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testProductSKUValidResponse() {
        let validResponseClient = FakeHTTPClient(jsonName: "SingleSKU")
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: validResponseClient,
                                                                 decoder: JSONDecoder())

        let exp = expectation(description: "response expectation")
        dataManager.sku(forSkuId: "", productId: "") { (sku, error) in
            guard error == nil else {
                XCTFail("Expected valid response and no errors, got error: \(String(describing: error))")
                return
            }
            guard let sku = sku else {
                XCTFail("Expected valid response, got nil sku")
                return
            }

            XCTAssertEqual(sku.resourceId, "12345")
            XCTAssertEqual(sku.price, 45)
            XCTAssertTrue(sku.isAvailable)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testInvalidResponse() {
        let invalidResponseClient = FakeHTTPClient(jsonName: "SingleError")
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: invalidResponseClient,
                                                                 decoder: JSONDecoder())

        let exp = expectation(description: "response expectation")
        dataManager.product(forProductId: "") { (_, error) in
            guard let error = error else {
                XCTFail("Expected an error")
                return
            }

            XCTAssertTrue(error is PCFError)
            XCTAssertEqual(error as? PCFError, PCFError.invalidJSON)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

}
