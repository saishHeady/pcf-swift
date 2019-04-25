//
//  PCFFilterEntry.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  PCFFilterEntry model.
 */
public struct PCFFilterEntry: FilterEntry, Swift.Decodable {

    public typealias ImageResourceType = PCFImageResource

    public let value: String
    public let label: String
    public let quantity: Int
    public let hex: String?
    public let imagePattern: ImageResourceType?
    public let isSelected: Bool

}

// MARK: - Swift.Decodable

public extension PCFFilterEntry {

    private enum FilterEntryCodingKeys: String, CodingKey {
        case value
        case label
        case quantity
        case hex
        case imagePattern
        case isSelected
    }

    public init(from decoder: Swift.Decoder) throws {
        let filterEntryContainer = try decoder.container(keyedBy: FilterEntryCodingKeys.self)

        value = try filterEntryContainer.decode(String.self, forKey: .value)
        label = try filterEntryContainer.decode(String.self, forKey: .label)
        quantity = try filterEntryContainer.decode(Int.self, forKey: .quantity)
        isSelected = try filterEntryContainer.decodeIfPresent(Bool.self, forKey: .isSelected) ?? false
        hex = try filterEntryContainer.decodeIfPresent(String.self, forKey: .hex)
        imagePattern = try filterEntryContainer.decodeIfPresent(ImageResourceType.self, forKey: .imagePattern)

    }

}
