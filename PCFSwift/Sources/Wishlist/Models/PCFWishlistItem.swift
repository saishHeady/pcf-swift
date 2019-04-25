//
//  PCFWishlistItem.swift
//  PCFSwift
//
//  Created by Thibault Klein on 6/16/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// PCF default wishlist item model.
public struct PCFWishlistItem: Wishlistable {

    public let resourceId: String
    public let state: WishlistItemState

    /// Initializes the wishlist item.
    ///
    /// - Parameters:
    ///   - resourceId: The resource id to use.
    ///   - state: The current wishlist item state.
    public init(resourceId: String, state: WishlistItemState) {
        self.resourceId = resourceId
        self.state = state
    }

}
