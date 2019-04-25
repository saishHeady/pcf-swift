//
//  Wishlist.swift
//  PCFSwift
//
//  Created by Thibault Klein on 8/1/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  Wishlist protocol.
 */
public protocol Wishlist {

    associatedtype ImageResourceType: ImageResource

    /// The id of the wishlist.
    var resourceId: String { get }

    /// The display name of the wishlist.
    var name: String { get }

    /// The number of items in the wishlist.
    var itemsCount: Int { get }

    /// Collection of images corresponding to some or all of the items.
    var images: [ImageResourceType] { get }

}
