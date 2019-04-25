//
//  ShopViewTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 8/16/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class ShopViewTests: XCTestCase {

    var shopView: PCFShopView!

    override func setUp() {
        super.setUp()

        do {
            let shopViewJSONData = try TestServer.getJSONData("SingleShopView")
            shopView = try JSONDecoder().decode(PCFShopView.self, from: shopViewJSONData)
        } catch {
            XCTFail("Can't open ShopView JSON")
        }
    }

    override func tearDown() {
        shopView = nil

        super.tearDown()
    }

    func testShopView() {
        XCTAssertTrue(shopView.mainNavigation.count == 2)
        XCTAssertTrue(shopView.secondaryNavigation.count == 1)
        XCTAssertTrue(shopView.featuredProducts.count == 1)
    }

    func testShopViewMainNavigation() {
        // Given
        let navigationItem = shopView.mainNavigation.first!
        // Then
        XCTAssertEqual(navigationItem.images.first?.url, URL(string: "http://img.url.jpg"))
        XCTAssertEqual(navigationItem.images.first?.usage, "small")
        XCTAssertEqual(navigationItem.text, "Get this awesome thing")
        XCTAssertEqual(navigationItem.navigation, "myapp://products/PRODUCTID")
    }

    func testShopViewSecondaryNavigation() {
        // Given
        let navigationItem = shopView.secondaryNavigation.first!
        // Then
        XCTAssertEqual(navigationItem.images.first?.url, URL(string: "http://img.url.secondary.jpg"))
        XCTAssertEqual(navigationItem.images.first?.usage, "large")
        XCTAssertEqual(navigationItem.text, "Get this awesome secondary thing")
        XCTAssertEqual(navigationItem.navigation, "myapp://products/secondary/PRODUCTID")
    }

}
