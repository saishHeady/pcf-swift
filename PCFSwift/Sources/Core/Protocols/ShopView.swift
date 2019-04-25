//
//  ShopView.swift
//  PCFSwift
//
//  Created by Thibault Klein on 8/16/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  Shop view protocol. Describes the main navigation menu.
 */
public protocol ShopView {

    associatedtype NavigationItemType: NavigationItem
    associatedtype ProductType: Product

    /// Collection of navigation item for the main navigation.
    var mainNavigation: [NavigationItemType] { get }

    /// Collection of navigation item for the secondary navigation.
    var secondaryNavigation: [NavigationItemType] { get }

    /// Collection of products.
    var featuredProducts: [ProductType] { get }

}
