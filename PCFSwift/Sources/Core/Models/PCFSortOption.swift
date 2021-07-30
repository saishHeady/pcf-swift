//
//  PCFSortOption.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  PCFSortOption model.
 */
public struct PCFSortOption: SortOption, Swift.Decodable {

    public let label: String
    public let sort: String
    public let order: String
    public let isSelected: Bool

}

// MARK: - Swift.Decodable

public extension PCFSortOption {

    private enum SortOptionCodingKeys: String, CodingKey {
        case label
        case sort
        case order
        case isSelected
    }

    init(from decoder: Swift.Decoder) throws {
        let sortOptionContainer = try decoder.container(keyedBy: SortOptionCodingKeys.self)

        label = try sortOptionContainer.decode(String.self, forKey: .label)
        sort = try sortOptionContainer.decode(String.self, forKey: .sort)
        order = try sortOptionContainer.decode(String.self, forKey: .order)
        isSelected = try sortOptionContainer.decodeIfPresent(Bool.self, forKey: .isSelected) ?? false

    }

}
