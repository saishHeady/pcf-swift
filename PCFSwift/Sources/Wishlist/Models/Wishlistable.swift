//
//  Wishlistable.swift
//  PCFSwift
//
//  Created by Thibault Klein on 1/20/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Describes the current wishlist item state.
///
/// - wishlisted: Indicates that the item is in a wishlist.
/// - unlisted: Indicates that the item is not in a wishlist.
public enum WishlistItemState {
    case wishlisted
    case unlisted

    /// Returns the reversed state of the current state.
    ///
    /// - Returns: The reversed state.
    public func reverse() -> WishlistItemState {
        switch self {
        case .wishlisted:
            return .unlisted
        case .unlisted:
            return .wishlisted
        }
    }
}

/// Wishlistable object.
public protocol Wishlistable {

    /// The wishlist item id.
    var resourceId: String { get }

    /// The wishlist item state.
    var state: WishlistItemState { get }

}
