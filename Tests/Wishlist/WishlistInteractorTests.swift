//
//  WishlistInteractorTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 1/21/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class WishlistInteractorTests: XCTestCase {

    var interactor: FakeWishlistInteractor!

    override func setUp() {
        super.setUp()

        let initialEnvironment = FakeHTTPEnvironment(name: "QA", baseURL: URL(string: "http://qa.api.io")!)
        let environments = [initialEnvironment]
        let environmentManager = FakeHTTPEnvironmentManager(environments: environments,
                                                            initialEnvironment: initialEnvironment)
        let httpClient = FakeHTTPClient()
        let sessionManager = PCFSessionManager(environmentManager: environmentManager, httpClient: httpClient)

        let wishlistDataManager = FakeWishlistDataManager(environmentManager: environmentManager,
                                                          httpClient: httpClient,
                                                          sessionManager: sessionManager,
                                                          decoder: JSONDecoder())
        interactor = FakeWishlistInteractor(wishlistDataManager: wishlistDataManager)
    }

    override func tearDown() {
        interactor = nil

        super.tearDown()
    }

    func isWishlistItem(_ wishlistItem: Wishlistable, isEqualTo otherItem: Wishlistable) -> Bool {
        return wishlistItem.resourceId == otherItem.resourceId && wishlistItem.state == otherItem.state
    }

    func areWishlistItems(_ wishlistItems: [Wishlistable], equalTo otherItems: [Wishlistable]) -> Bool {
        var result = true
        for (index, item) in wishlistItems.enumerated() {
            result = result && isWishlistItem(item, isEqualTo: otherItems[index])
        }

        return result
    }

    func testGetWishlist() {
        let expectedItems: [Wishlistable] = [
            FakeWishlistItem(resourceId: "1", state: .wishlisted),
            FakeWishlistItem(resourceId: "2", state: .wishlisted),
            FakeWishlistItem(resourceId: "3", state: .wishlisted),
            FakeWishlistItem(resourceId: "4", state: .wishlisted)
        ]
        let exp = expectation(description: "Expecting wishlist items")

        _ = interactor.wishlist(accountId: "", filter: nil, limit: 20, offset: 0) { (items, _) in
            for (index, item) in items.enumerated() {
                XCTAssertTrue(self.isWishlistItem(item, isEqualTo: expectedItems[index]))
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testGetWishlistItem() {
        let expectedItem: Wishlistable = FakeWishlistItem(resourceId: "2", state: .wishlisted)
        let exp = expectation(description: "Expecting wishlist items")

        _ = interactor.wishlistItem(itemId: "2", accountId: "") { (item, _) in
            guard let item = item else {
                fatalError()
            }

            XCTAssertTrue(self.isWishlistItem(item, isEqualTo: expectedItem))
            exp.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testAddToWishlist() {
        let expectedItems: [Wishlistable] = [
            FakeWishlistItem(resourceId: "1", state: .wishlisted),
            FakeWishlistItem(resourceId: "2", state: .wishlisted),
            FakeWishlistItem(resourceId: "3", state: .wishlisted),
            FakeWishlistItem(resourceId: "4", state: .wishlisted),
            FakeWishlistItem(resourceId: "5", state: .wishlisted)
        ]
        let exp = expectation(description: "Expecting wishlist items")

        _ = interactor.addWishlistItem(itemId: "5", accountId: "", completion: { (items, _) in
            XCTAssertTrue(self.areWishlistItems(items, equalTo: expectedItems))
            exp.fulfill()
        })

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testRemoveFromWishlist() {
        let expectedItems: [Wishlistable] = [
            FakeWishlistItem(resourceId: "1", state: .wishlisted),
            FakeWishlistItem(resourceId: "3", state: .wishlisted),
            FakeWishlistItem(resourceId: "4", state: .wishlisted)
        ]
        let exp = expectation(description: "Expecting wishlist items")

        _ = interactor.removeWishlistItem(itemId: "2", accountId: "", completion: { (items, _) in
            XCTAssertTrue(self.areWishlistItems(items, equalTo: expectedItems))
            exp.fulfill()
        })

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testUpdateWishlist() {
        let expectedItems: [Wishlistable] = [
            FakeWishlistItem(resourceId: "1", state: .wishlisted),
            FakeWishlistItem(resourceId: "2", state: .wishlisted),
            FakeWishlistItem(resourceId: "3", state: .unlisted),
            FakeWishlistItem(resourceId: "4", state: .unlisted)
        ]
        let exp = expectation(description: "Expecting wishlist items")
        let itemsToUpdate = [FakeWishlistItem(resourceId: "3", state: .unlisted),
                             FakeWishlistItem(resourceId: "4", state: .unlisted)]

        _ = interactor.updateWishlistItems(items: itemsToUpdate, accountId: "", completion: { (items, _) in
            for (index, item) in items.enumerated() {
                XCTAssertTrue(self.isWishlistItem(item, isEqualTo: expectedItems[index]))
            }

            exp.fulfill()
        })

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testResetWishlist() {
        let exp = expectation(description: "Expecting wishlist items")

        _ = interactor.wishlist(accountId: "", filter: nil, limit: 20, offset: 0) { _, _ in
            self.interactor.resetWishlist()
            XCTAssertTrue(self.interactor.wishlistItems.isEmpty)

            exp.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
