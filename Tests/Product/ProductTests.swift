//
//  ProductTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/5/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class ProductTests: XCTestCase {

    var product: PCFProduct!
    var color: PCFColor!

    override func setUp() {
        super.setUp()
        do {
            let productJSONData = try TestServer.getJSONData("SingleProduct")
            product = try JSONDecoder().decode(PCFProduct.self, from: productJSONData)
        } catch {
            XCTFail("Can't open Product JSON")
        }

        do {
            let colorJSONData = try TestServer.getJSONData("SingleColor")
            color = try JSONDecoder().decode(PCFColor.self, from: colorJSONData)
        } catch {
            XCTFail("Can't open Color JSON")
        }
    }

    override func tearDown() {
        product = nil
        super.tearDown()
    }

    func testProduct() {
        XCTAssertEqual(product.resourceId, "1234")
        XCTAssertEqual(product.name, "Vera")
        XCTAssertEqual(product.price, 45.0)
        XCTAssertEqual(product.discountedPrice, 40.0)
        XCTAssertEqual(product.productDescription, "<p>Gorgeous lace ...")
        XCTAssertNotNil(product.imageResources)
        XCTAssertTrue(product.imageIds.count == 2)
        XCTAssertEqual(product.imageIds[0], "1")
        XCTAssertEqual(product.imageIds[1], "2")
    }

    func testProductUserReviews() {
        XCTAssertEqual(product.userReviews?.reviewCount, 10)
        XCTAssertEqual(product.userReviews?.overallRating, 4.6)
        XCTAssertEqual(product.userReviews?.maxRating, 5)
    }

    func testProductImageResource_imageURLs() {
        // Given
        let imageURLs = product.imageURLs(usage: "large")
        // When
        let expectedImageURLs = [URL(string: "http://www.url3.jpg")!, URL(string: "http://www.url6.jpg")!]
        // Then
        XCTAssertEqual(imageURLs, expectedImageURLs)
    }

    func testProductImageResource_imageURLWithImageId() {
        // Given
        let imageURL = product.imageURL(withImageId: "1", usage: "large")
        // When
        let expectedImageURL = URL(string: "http://www.url3.jpg")
        // Then
        XCTAssertEqual(imageURL, expectedImageURL)
    }

}
