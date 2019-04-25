//
//  PCFNavigationItem.swift
//  PCFSwift
//
//  Created by Thibault Klein on 8/16/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  Navigation item model. Usually contains a deeplink.
 */
public struct PCFNavigationItem: NavigationItem, Swift.Decodable {

    public typealias ImageType = PCFImageResource

    /// Collection of Image. Can be empty (if `text` exists).
    public let images: [ImageType]

    /// Extra text that may accompany the images in the navigation. Can be null (if `images` exists).
    public let text: String?

    /// Internal navugation URL. Supports linking directly to internal company interfaces.
    /// See main descriptions for more details
    public let navigation: String

}

// MARK: - Swift.Decodable

public extension PCFNavigationItem {

    private enum NavigationItemCodingKeys: String, CodingKey {
        case navigation
        case images
        case text
    }

    public init(from decoder: Swift.Decoder) throws {
        let navigationContainer = try decoder.container(keyedBy: NavigationItemCodingKeys.self)

        navigation = try navigationContainer.decode(String.self, forKey: .navigation)
        images = try navigationContainer.decodeIfPresent([ImageType].self, forKey: .images) ?? []
        text = try navigationContainer.decodeIfPresent(String.self, forKey: .text)

    }

}
