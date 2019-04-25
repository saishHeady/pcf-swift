//
//  PCFCategory.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  PCFCategory model.
 */
public struct PCFCategory: Category, Swift.Decodable {

    public typealias ImageResourceType = PCFImageResource

    /// The category id.
    public let resourceId: String

    /// The category name.
    public let name: String

    /// The category images.
    public let images: [ImageResourceType]

    /// The category parent ids.
    public let parentCategoryIds: [CategoryId]

    /// The category tags.
    public let tags: [String]

    /// The category sub-category ids.
    public let subCategoryIds: [CategoryId]

}

// MARK: - Swift.Decodable

public extension PCFCategory {

    private enum CategoryCodingKeys: String, CodingKey {
        case resourceId = "id"
        case name
        case images
        case parentCategoryIds
        case tags
        case subCategoryIds
    }

    public init(from decoder: Swift.Decoder) throws {
        let categoryContainer = try decoder.container(keyedBy: CategoryCodingKeys.self)

        resourceId = try categoryContainer.decode(String.self, forKey: .resourceId)
        name = try categoryContainer.decode(String.self, forKey: .name)
        images = try categoryContainer.decodeIfPresent([ImageResourceType].self, forKey: .images) ?? []
        parentCategoryIds = try categoryContainer.decodeIfPresent([CategoryId].self, forKey: .parentCategoryIds) ?? []
        tags = try categoryContainer.decodeIfPresent([String].self, forKey: .tags) ?? []
        subCategoryIds = try categoryContainer.decodeIfPresent([CategoryId].self, forKey: .subCategoryIds) ?? []
    }

}
