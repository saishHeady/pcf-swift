//
//  NavigationItem.swift
//  PCFSwift
//
//  Created by Thibault Klein on 8/16/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  Navigation item protocol. Describes a navigation item. Usually contains a deeplink.
 */
public protocol NavigationItem {

    associatedtype ImageType: ImageResource

    /// Collection of Image. Can be empty (if `text` exists).
    var images: [ImageType] { get }

    /// Extra text that may accompany the images in the navigation. Can be null (if `images` exists).
    var text: String? { get }

    /// Internal navugation URL. Supports linking directly to internal company interfaces.
    /// See main descriptions for more details
    var navigation: String { get }

}
