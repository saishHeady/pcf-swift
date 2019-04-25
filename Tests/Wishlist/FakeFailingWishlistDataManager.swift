//
//  FakeFailingWishlistDataManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 6/16/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

@testable import PCFSwift

struct FakeFailingWishlistDataManager: WishlistDataManager {

    var environmentManager: HTTPEnvironmentManager
    var httpClient: HTTPClient
    var sessionManager: SessionManager
    var decoder: JSONDecoder

    func wishlist(accountId: String,
                  filter: [String]?,
                  limit: Int,
                  offset: Int,
                  completion: @escaping ([Wishlistable], Swift.Error?) -> Void) {
        completion([], PCFError(code: 1, message: ""))
    }

    func wishlistItem(itemId: String,
                      accountId: String,
                      completion: @escaping (Wishlistable?, Swift.Error?) -> Void) {
        completion(nil, PCFError(code: 1, message: ""))
    }

    func addWishlistItem(itemId: String,
                         accountId: String,
                         completion: @escaping (Bool, Swift.Error?) -> Void) {
        completion(false, PCFError(code: 1, message: ""))
    }

    func removeWishlistItem(itemId: String,
                            accountId: String,
                            completion: @escaping (Bool, Swift.Error?) -> Void) {
        completion(false, PCFError(code: 1, message: ""))
    }

    func updateWishlistItems(items: [Wishlistable],
                             accountId: String,
                             completion: @escaping (Bool, Swift.Error?) -> Void) {
        completion(false, PCFError(code: 1, message: ""))
    }

}
