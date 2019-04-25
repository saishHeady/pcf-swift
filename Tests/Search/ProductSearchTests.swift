//
//  ProductSearchTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class ProductSearchTests: XCTestCase {

    var productSearch: PCFProductSearch!

    override func setUp() {
        super.setUp()
        do {
            let productSearchJSONData = try TestServer.getJSONData("SingleProductSearch")
            productSearch = try JSONDecoder().decode(PCFProductSearch.self, from: productSearchJSONData)
        } catch {
            XCTFail("Can't open ProductSearch JSON")
        }
    }

    override func tearDown() {
        productSearch = nil
        super.tearDown()
    }

    func testProductSearch() {
        XCTAssertEqual(productSearch.totalResults, 1)
        XCTAssertNotNil(productSearch.products)
        XCTAssertNotNil(productSearch.filters)
        XCTAssertNotNil(productSearch.sortOptions)
    }

    func testProductSearchProducts() {
        XCTAssertTrue(productSearch.products.count == 1)

        // Given
        let product = productSearch.products.first!
        // Then
        XCTAssertEqual(product.resourceId, "1234")
        XCTAssertEqual(product.name, "Vera")
        XCTAssertEqual(product.price, 45)
        XCTAssertEqual(product.discountedPrice, 40)
        XCTAssertEqual(product.productDescription, "<p>Gorgeous lace ...")
    }

    func testProductSearchFilters() {
        XCTAssertTrue(productSearch.filters.count == 1)

        // Given
        let filter = productSearch.filters.first!
        // Then
        XCTAssertEqual(filter.resourceId, "color")
        XCTAssertEqual(filter.name, "Color")
    }

    func testProductSearchFilterEntries() {
        // Given
        let filter = productSearch.filters.first!
        let firstEntry = filter.entries[0]
        // Then
        XCTAssertTrue(filter.entries.count == 2)
        XCTAssertEqual(firstEntry.value, "bluish")
        XCTAssertEqual(firstEntry.label, "Blue-ish")
        XCTAssertEqual(firstEntry.quantity, 1)
        XCTAssertTrue(firstEntry.isSelected)
    }

    func testProductSearchSortOptions() {
        XCTAssertTrue(productSearch.sortOptions.count == 2)

        // Given
        let firstSortOption = productSearch.sortOptions[0]
        // Then
        XCTAssertEqual(firstSortOption.label, "Bestsellers")
        XCTAssertEqual(firstSortOption.sort, "popularity")
        XCTAssertEqual(firstSortOption.order, "desc")
        XCTAssertTrue(firstSortOption.isSelected)
    }

}
