//
//  WishlistDataManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 1/20/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Wishlist Data Manager protocol.
public protocol WishlistDataManager: DataManager {

    /// Get the entire user's wishlist. Can also get a filtered list of products and paginate the results.
    ///
    /// - parameter accountId:    The user's account id.
    /// - parameter filter:       List of item ids to use as a filter for the returned list.
    /// - parameter limit:        The number of records to return.
    /// - parameter offset:       Used to paginate. First page of results is 0.
    /// - parameter completion:   The completion block.
    func wishlist(accountId: String,
                  filter: [String]?,
                  limit: Int,
                  offset: Int,
                  completion: @escaping (_ items: [Wishlistable], _ error: Swift.Error?) -> Void)

    /// Get a specific item by using its id.
    ///
    /// - parameter itemId:       The item id to get.
    /// - parameter accountId:    The user's account id.
    /// - parameter completion:   The completion block.
    func wishlistItem(itemId: String,
                      accountId: String,
                      completion: @escaping (_ item: Wishlistable?, _ error: Swift.Error?) -> Void)

    /// Adds an item to the wishlist.
    ///
    /// - parameter itemId:       The item id to add.
    /// - parameter accountId:    The user's account id.
    /// - parameter completion:   The completion block.
    func addWishlistItem(itemId: String,
                         accountId: String,
                         completion: @escaping (_ success: Bool, _ error: Swift.Error?) -> Void)

    /// Removes an item from the wishlist.
    ///
    /// - parameter itemId:       The item id to remove.
    /// - parameter accountId:    The user's account id.
    /// - parameter completion:   The completion block.
    func removeWishlistItem(itemId: String,
                            accountId: String,
                            completion: @escaping (_ success: Bool, _ error: Swift.Error?) -> Void)

    /// Updates a bulk of items for the user's account.
    /// * Items with `state=Wishlisted` will be added.
    /// * Items with `state=Unlisted` will be removed from the wishlist.
    ///
    /// - parameter items:        The items to update.
    /// - parameter accountId:    The user's account id.
    /// - parameter completion:   The completion block.
    func updateWishlistItems(items: [Wishlistable],
                             accountId: String,
                             completion: @escaping (_ success: Bool, _ error: Swift.Error?) -> Void)

}
