//
//  PCFWishlist.swift
//  PCFSwift
//
//  Created by Thibault Klein on 8/1/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  PCFWishlist model.
 */
public struct PCFWishlist: Wishlist, Swift.Decodable {

    public typealias ImageResourceType = PCFImageResource

    /// The id of the wishlist.
    public let resourceId: String

    /// The display name of the wishlist.
    public let name: String

    /// The number of items in the wishlist.
    public let itemsCount: Int

    /// Collection of images corresponding to some or all of the items.
    public let images: [ImageResourceType]

}

// MARK: - Swift.Decodable

public extension PCFWishlist {

    private enum WishlistCodingKeys: String, CodingKey {
        case resourceId = "id"
        case name
        case itemsCount = "itemCount"
        case images
    }

    init(from decoder: Swift.Decoder) throws {
        let wishlistContainer = try decoder.container(keyedBy: WishlistCodingKeys.self)

        resourceId = try wishlistContainer.decode(String.self, forKey: .resourceId)
        name = try wishlistContainer.decode(String.self, forKey: .name)
        itemsCount = try wishlistContainer.decode(Int.self, forKey: .itemsCount)
        images = try wishlistContainer.decodeIfPresent([ImageResourceType].self, forKey: .images) ?? []

    }

}
