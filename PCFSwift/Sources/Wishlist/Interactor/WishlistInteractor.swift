//
//  WishlistInteractor.swift
//  PCFSwift
//
//  Created by Thibault Klein on 1/21/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Wishlist Interactor protocol.
public protocol WishlistInteractor: class {

    associatedtype WishlistItem: Wishlistable

    /// Wishlist items recently updated.
    var wishlistItems: [Wishlistable] { get set }

    /// Wishlist data manager.
    var wishlistDataManager: WishlistDataManager { get }

    /// Get the entire user's wishlist. Can also get a filtered list of products and paginate the results.
    ///
    /// - parameter accountId:    The user's account id.
    /// - parameter filter:       List of item ids to use as a filter for the returned list.
    /// - parameter limit:        The number of records to return. Default value is 100.
    /// - parameter offset:       Used to paginate. First page of results is 0. Default value is 0
    /// - parameter completion:   The completion block.
    ///
    /// - returns: The local state of the items. Used to provide instant feedback while the API call performs.
    func wishlist(accountId: String,
                  filter: [String]?,
                  limit: Int,
                  offset: Int,
                  completion: @escaping (_ items: [Wishlistable], _ error: Swift.Error?) -> Void) -> [Wishlistable]

    /// Get a specific item by using its id.
    ///
    /// - parameter itemId:       The item id to get.
    /// - parameter accountId:    The user's account id.
    /// - parameter completion:   The completion block.
    ///
    /// - returns: The local state of the item. Used to provide instant feedback while the API call performs.
    func wishlistItem(itemId: String,
                      accountId: String,
                      completion: @escaping (_ items: Wishlistable?, _ error: Swift.Error?) -> Void)
        -> WishlistItemState

    /// Adds an item to the wishlist.
    ///
    /// - parameter itemId:       The item id to add.
    /// - parameter accountId:    The user's account id.
    /// - parameter completion:   The completion block.
    func addWishlistItem(itemId: String,
                         accountId: String,
                         completion: @escaping (_ items: [Wishlistable], _ error: Swift.Error?) -> Void)

    /// Removes an item from the wishlist.
    ///
    /// - parameter itemId:       The item id to remove.
    /// - parameter accountId:    The user's account id.
    /// - parameter completion:   The completion block.
    func removeWishlistItem(itemId: String,
                            accountId: String,
                            completion: @escaping (_ items: [Wishlistable], _ error: Swift.Error?) -> Void)

    /// Updates a bulk of items for the user's account.
    /// * Items with `state=Wishlisted` will be added.
    /// * Items with `state=Unlisted` will be removed from the wishlist.
    ///
    /// - parameter items:        The items to update.
    /// - parameter accountId:    The user's account id.
    /// - parameter completion:   The completion block.
    func updateWishlistItems(items: [Wishlistable],
                             accountId: String,
                             completion: @escaping (_ items: [Wishlistable], _ error: Swift.Error?) -> Void)

    /// Indicates the product id wishlist state.
    ///
    /// - parameter productId: The product id to use.
    ///
    /// - returns: The product id state in the wishlist.
    func wishlistState(forProductId productId: String) -> WishlistItemState

    /// Indicates the product ids wishlist states.
    ///
    /// - Parameter productIds: The product ids to use.
    /// - Returns: The wishlist items that are accessible from the wishlist.
    func wishlistItems(forProductIds productIds: [String]) -> [Wishlistable]

}

public extension WishlistInteractor {

    func wishlist(accountId: String,
                  filter: [String]?,
                  limit: Int,
                  offset: Int,
                  completion: @escaping (_ items: [Wishlistable], _ error: Swift.Error?) -> Void) -> [Wishlistable] {
        wishlistDataManager.wishlist(accountId: accountId,
                                     filter: filter,
                                     limit: limit,
                                     offset: offset) { (items, error) in
                                        self.handleItemsCompletion(result: (items, error), completion: completion)
        }

        return wishlistItems(forProductIds: filter ?? [String]())
    }

    func wishlistItem(itemId: String,
                      accountId: String,
                      completion: @escaping (_ items: Wishlistable?, _ error: Swift.Error?) -> Void)
        -> WishlistItemState {
            wishlistDataManager.wishlistItem(itemId: itemId,
                                             accountId: accountId) { (item, error) in
                                                if let item = item {
                                                    self.wishlistItems.append(item)
                                                }

                                                completion(item, error)
            }

            return wishlistState(forProductId: itemId)
    }

    func addWishlistItem(itemId: String,
                         accountId: String,
                         completion: @escaping (_ items: [Wishlistable], _ error: Swift.Error?) -> Void) {
        wishlistDataManager.addWishlistItem(itemId: itemId,
                                            accountId: accountId) { (success, error) in
                                                self.handleAddWishlistItem(itemId: itemId,
                                                                           success: success,
                                                                           error: error,
                                                                           completion: completion)
        }
    }

    func removeWishlistItem(itemId: String,
                            accountId: String,
                            completion: @escaping (_ items: [Wishlistable], _ error: Swift.Error?) -> Void) {
        wishlistDataManager.removeWishlistItem(itemId: itemId,
                                               accountId: accountId) { (success, error) in
                                                self.handleRemoveWishlistItem(itemId: itemId,
                                                                              success: success,
                                                                              error: error,
                                                                              completion: completion)
        }
    }

    func updateWishlistItems(items: [Wishlistable],
                             accountId: String,
                             completion: @escaping (_ items: [Wishlistable], _ error: Swift.Error?) -> Void) {
        wishlistDataManager.updateWishlistItems(items: items,
                                                accountId: accountId) { (success, error) in
                                                    self.handleUpdateWishlistItem(items: items,
                                                                                  success: success,
                                                                                  error: error,
                                                                                  completion: completion)
        }
    }

    func wishlistState(forProductId productId: String) -> WishlistItemState {
        if let index = wishlistItems.firstIndex(where: { $0.resourceId == productId }) {
            let item = wishlistItems[index]
            return item.state
        }

        return .unlisted
    }

    func wishlistItems(forProductIds productIds: [String]) -> [Wishlistable] {
        var items = [Wishlistable]()

        for productId in productIds {
            if let product = wishlistItems.filter({ $0.resourceId == productId }).first {
                items.append(product)
            }
        }

        return items
    }

    /// Resets the wishlist. Call this function when the user logs out or when no account id is available.
    func resetWishlist() {
        wishlistItems.removeAll()
    }

    private func handleItemsCompletion(result: (items: [Wishlistable], error: Swift.Error?),
                                       completion: @escaping (_ items: [Wishlistable], _ error: Swift.Error?) -> Void) {
        if result.error == nil {
            self.wishlistItems = result.items
        }

        completion(result.items, result.error)
    }

    private func handleAddWishlistItem(itemId: String,
                                       success: Bool,
                                       error: Swift.Error?,
                                       completion: @escaping (_ items: [Wishlistable], _ error: Swift.Error?)
        -> Void) {
        if success == true {
            let wishlistItem = PCFWishlistItem(resourceId: itemId,
                                               state: .wishlisted)
            self.wishlistItems.append(wishlistItem)
            completion(self.wishlistItems, nil)
        } else if let error = error {
            completion([], error)
        } else {
            completion(self.wishlistItems, nil)
        }
    }

    private func handleRemoveWishlistItem(itemId: String,
                                          success: Bool,
                                          error: Swift.Error?,
                                          completion: @escaping (_ items: [Wishlistable], _ error: Swift.Error?)
        -> Void) {
        if success == true {
            for (index, item) in self.wishlistItems.enumerated()
                where item.resourceId == itemId {
                    self.wishlistItems.remove(at: index)
                    break
            }

            completion(self.wishlistItems, nil)
        } else if let error = error {
            completion([], error)
        } else {
            completion(self.wishlistItems, nil)
        }
    }

    private func handleUpdateWishlistItem(items: [Wishlistable],
                                          success: Bool,
                                          error: Swift.Error?,
                                          completion: @escaping (_ items: [Wishlistable], _ error: Swift.Error?)
        -> Void) {
        if success == true {
            for (index, item) in self.wishlistItems.enumerated() {
                if let matchingItem = items
                    .filter({ $0.resourceId == item.resourceId })
                    .first {
                    let newItem = PCFWishlistItem(resourceId: item.resourceId,
                                                  state: matchingItem.state)
                    self.wishlistItems.remove(at: index)
                    self.wishlistItems.insert(newItem, at: index)
                }
            }

            completion(self.wishlistItems, nil)
        } else if let error = error {
            completion([], error)
        } else {
            completion(self.wishlistItems, nil)
        }
    }

}
