//
//  WishlistInteractorFailureTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 6/16/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class WishlistInteractorFailureTests: XCTestCase {

    var interactor: FakeWishlistInteractor!

    override func setUp() {
        super.setUp()

        let initialEnvironment = FakeHTTPEnvironment(name: "QA", baseURL: URL(string: "http://qa.api.io")!)
        let environments = [initialEnvironment]
        let environmentManager = FakeHTTPEnvironmentManager(environments: environments,
                                                            initialEnvironment: initialEnvironment)
        let httpClient = FakeHTTPClient()
        let sessionManager = PCFSessionManager(environmentManager: environmentManager, httpClient: httpClient)

        let wishlistDataManager = FakeFailingWishlistDataManager(environmentManager: environmentManager,
                                                                 httpClient: httpClient,
                                                                 sessionManager: sessionManager,
                                                                 decoder: JSONDecoder())
        interactor = FakeWishlistInteractor(wishlistDataManager: wishlistDataManager)
    }

    override func tearDown() {
        interactor = nil

        super.tearDown()
    }

    func testGetWishlist_whenAnErrorReturns() {
        let exp = expectation(description: "Expecting error")

        _ = interactor.wishlist(accountId: "", filter: nil, limit: 20, offset: 0) { (_, error) in
            XCTAssertNotNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testGetWishlistItem_whenAnErrorReturns() {
        let exp = expectation(description: "Expecting error")

        _ = interactor.wishlistItem(itemId: "2", accountId: "") { (_, error) in
            XCTAssertNotNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testAddToWishlist_whenAnErrorReturns() {
        let exp = expectation(description: "Expecting error")

        _ = interactor.addWishlistItem(itemId: "5", accountId: "", completion: { (_, error) in
            XCTAssertNotNil(error)
            exp.fulfill()
        })

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testRemoveFromWishlist_whenAnErrorReturns() {
        let exp = expectation(description: "Expecting error")

        _ = interactor.removeWishlistItem(itemId: "2", accountId: "", completion: { (_, error) in
            XCTAssertNotNil(error)
            exp.fulfill()
        })

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testUpdateWishlist_whenAnErrorReturns() {
        let exp = expectation(description: "Expecting error")
        let itemsToUpdate = [FakeWishlistItem(resourceId: "3", state: .unlisted),
                             FakeWishlistItem(resourceId: "4", state: .unlisted)]

        _ = interactor.updateWishlistItems(items: itemsToUpdate, accountId: "", completion: { (_, error) in
            XCTAssertNotNil(error)
            exp.fulfill()
        })

        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
