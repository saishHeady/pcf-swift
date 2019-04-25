//
//  WishlistTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 8/1/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class WishlistTests: XCTestCase {

    var wishlist: PCFWishlist!

    override func setUp() {
        super.setUp()

        do {
            let wishlistJSONData = try TestServer.getJSONData("SingleWishlist")
            wishlist = try JSONDecoder().decode(PCFWishlist.self, from: wishlistJSONData)
        } catch {
            XCTFail("Can't open Wishlist JSON")
        }
    }

    override func tearDown() {
        wishlist = nil

        super.tearDown()
    }

    func testWishList() {
        XCTAssertEqual(wishlist.resourceId, "1")
        XCTAssertEqual(wishlist.name, "My Wishlist")
        XCTAssertEqual(wishlist.itemsCount, 12)
        XCTAssertEqual(wishlist.images[0].url.absoluteString, "http://img.url.jpg")
        XCTAssertEqual(wishlist.images[0].usage, "small")
    }

}
