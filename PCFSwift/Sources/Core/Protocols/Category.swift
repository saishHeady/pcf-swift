//
//  Category.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/// Category id definition.
public typealias CategoryId = String

/**
 *  Category protocol.
 */
public protocol Category {

    associatedtype ImageResourceType: ImageResource

    /// The category id.
    var resourceId: String { get }

    /// The category name.
    var name: String { get }

    /// The category images.
    var images: [ImageResourceType] { get }

    /// The category parent ids.
    var parentCategoryIds: [CategoryId] { get }

    /// The category tags.
    var tags: [String] { get }

    /// The category sub-category ids.
    var subCategoryIds: [CategoryId] { get }

}
