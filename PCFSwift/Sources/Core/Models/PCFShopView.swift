//
//  PCFShopView.swift
//  PCFSwift
//
//  Created by Thibault Klein on 8/16/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  Shop view model.
 */
public struct PCFShopView: ShopView, Swift.Decodable {

    public typealias NavigationItemType = PCFNavigationItem
    public typealias ProductType = PCFProduct

    /// Collection of navigation item for the main navigation.
    public let mainNavigation: [NavigationItemType]

    /// Collection of navigation item for the secondary navigation.
    public let secondaryNavigation: [NavigationItemType]

    /// Collection of products.
    public let featuredProducts: [ProductType]

}

// MARK: - Swift.Decodable

public extension PCFShopView {

    private enum ShopViewCodingKeys: String, CodingKey {
        case mainNavigation
        case secondaryNavigation
        case featuredProducts
    }

    public init(from decoder: Swift.Decoder) throws {
        let shopViewContainer = try decoder.container(keyedBy: ShopViewCodingKeys.self)

        mainNavigation = try shopViewContainer.decodeIfPresent([NavigationItemType].self, forKey: .mainNavigation) ?? []
        secondaryNavigation = try shopViewContainer.decodeIfPresent([NavigationItemType].self, forKey: .secondaryNavigation) ?? []
        featuredProducts = try shopViewContainer.decodeIfPresent([ProductType].self, forKey: .featuredProducts) ?? []

    }

}
