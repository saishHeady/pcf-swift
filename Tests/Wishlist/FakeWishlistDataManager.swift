//
//  FakeWishlistDataManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 1/21/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

@testable import PCFSwift

struct FakeWishlistDataManager: WishlistDataManager {

    var environmentManager: HTTPEnvironmentManager
    var httpClient: HTTPClient
    var sessionManager: SessionManager
    var decoder: JSONDecoder

    func wishlist(accountId: String,
                  filter: [String]?,
                  limit: Int,
                  offset: Int,
                  completion: @escaping ([Wishlistable], Swift.Error?) -> Void) {
        completion(createFakeWishlistItems(), nil)
    }

    func wishlistItem(itemId: String,
                      accountId: String,
                      completion: @escaping (Wishlistable?, Swift.Error?) -> Void) {
        let items = createFakeWishlistItems()
        let item = items.filter { $0.resourceId == itemId }.first!
        completion(item, nil)
    }

    func addWishlistItem(itemId: String,
                         accountId: String,
                         completion: @escaping (Bool, Swift.Error?) -> Void) {
        completion(true, nil)
    }

    func removeWishlistItem(itemId: String,
                            accountId: String,
                            completion: @escaping (Bool, Swift.Error?) -> Void) {
        completion(true, nil)
    }

    func updateWishlistItems(items: [Wishlistable],
                             accountId: String,
                             completion: @escaping (Bool, Swift.Error?) -> Void) {
        completion(true, nil)
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
