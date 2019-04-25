//
//  FakeWishlistInteractor.swift
//  PCFSwift
//
//  Created by Thibault Klein on 1/21/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

@testable import PCFSwift

class FakeWishlistInteractor: WishlistInteractor {

    typealias WishlistItem = PCFWishlistItem

    var wishlistItems: [Wishlistable] = []
    var wishlistDataManager: WishlistDataManager

    init(wishlistDataManager: WishlistDataManager) {
        self.wishlistDataManager = wishlistDataManager
        wishlistItems = createFakeWishlistItems()
    }

    func createFakeWishlistItems() -> [Wishlistable] {
        return [
            FakeWishlistItem(resourceId: "1", state: .wishlisted),
            FakeWishlistItem(resourceId: "2", state: .wishlisted),
            FakeWishlistItem(resourceId: "3", state: .wishlisted),
            FakeWishlistItem(resourceId: "4", state: .wishlisted)
        ]
    }

}
