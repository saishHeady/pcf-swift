//
//  ProductSearchDataManagerTests.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 4/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class ProductSearchDataManagerTests: BaseTestDataManager {

    func testGetFilteredProductsRequest() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = ProductSearchDataManager<PCFProductSearch>(environmentManager: envManager,
                                                                     sessionManager: sessionManager,
                                                                     httpClient: validResponseClient,
                                                                     decoder: JSONDecoder())

        let searchCriteria = PCFProductSearchCriteria(keyword: "pants",
                                                      filterItems: ["color": "bluish,redish",
                                                                    "style": "This Just In"],
                                                      pageInformation: PageInformation(offset: 100, limit: 50))
        let queryItems = searchCriteria.toQueryItems()

        let request = dataManager.getProductSearchRequest(forPath: "/products/search",
                                                          queryItems: queryItems)
        let headers = dataManager.headers(forEnvironment: envManager.currentEnvironment)
        // When
        let expectedRequest = HTTPRequest(method: .get,
                                          baseURL: envManager.currentEnvironment.baseURL,
                                          path: "/products/search",
                                          queryItems: queryItems,
                                          parameters: nil,
                                          headers: headers)
        // Then
        XCTAssertEqual(request.baseURL, expectedRequest.baseURL)
        XCTAssertEqual(request.method, expectedRequest.method)
        XCTAssertEqual(request.endpoint, expectedRequest.endpoint)
        XCTAssertEqual(request.path, expectedRequest.path)
        XCTAssertEqual(request.headers!, expectedRequest.headers!)
        XCTAssertTrue(request.endpoint.absoluteString.contains("color=bluish,redish"))
        XCTAssertTrue(request.endpoint.absoluteString.contains("style=This%20Just%20In"))
    }

    func testProductSearchValidResponse() {
        //Given
        let validResponseClient = FakeHTTPClient(jsonName: "SingleProductSearch")
        let exp = expectation(description: "response expectation")

        let dataManager = ProductSearchDataManager<PCFProductSearch>(environmentManager: envManager,
                                                                     sessionManager: sessionManager,
                                                                     httpClient: validResponseClient,
                                                                     decoder: JSONDecoder())

        let searchCriteria = PCFProductSearchCriteria(categoryId: "10018",
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100))

        //When
        dataManager.filteredProducts(searchCriteria: searchCriteria) { (productSearch, error) in
            //Then
            guard error == nil else {
                XCTFail("Expected valid response and no errors, got error: \(String(describing: error))")
                return
            }

            guard let productSearch = productSearch else {
                XCTFail("Expected valid response, got nil product search response")
                return
            }

            XCTAssertEqual(productSearch.totalResults, 1)
            XCTAssertTrue(productSearch.products.count == 1)
            XCTAssertTrue(productSearch.filters.count == 1)
            XCTAssertTrue(productSearch.filters.first!.entries.count == 2)
            XCTAssertTrue(productSearch.sortOptions.count == 2)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testProductSearchEmptyResponse() {
        //Given
        let validResponseClient = FakeHTTPClient(jsonName: "ProductSearchEmptyResponse")
        let exp = expectation(description: "response expectation")

        let dataManager = ProductSearchDataManager<PCFProductSearch>(environmentManager: envManager,
                                                                     sessionManager: sessionManager,
                                                                     httpClient: validResponseClient,
                                                                     decoder: JSONDecoder())

        //When
        dataManager.filteredProducts(searchCriteria: PCFProductSearchCriteria()) { (productSearch, error) in
            //Then
            guard error == nil else {
                XCTFail("Expected valid response and no errors, got error: \(String(describing: error))")
                return
            }

            guard let productSearch = productSearch else {
                XCTFail("Expected valid response, got nil product search response")
                return
            }

            XCTAssertEqual(productSearch.totalResults, 0)
            XCTAssertTrue(productSearch.products.isEmpty)
            XCTAssertTrue(productSearch.filters.isEmpty)
            XCTAssertTrue(productSearch.sortOptions.isEmpty)

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
