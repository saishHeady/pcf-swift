//
//  PCFFilter.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  PCFFilter model.
 */
public struct PCFFilter: Filter, Swift.Decodable {

    public typealias FilterEntryType = PCFFilterEntry

    /// The key used to make a search using this filter.
    public let resourceId: String

    /// The display name of the filter.
    public let name: String

    /// Filter entries.
    public let entries: [FilterEntryType]

    /// Whether or not the filter allows selecting multiple filter entries.
    public let allowsMultipleSelections: Bool

}

// MARK: - Swift.Decodable

public extension PCFFilter {

    private enum FilterCodingKeys: String, CodingKey {
        case resourceId = "id"
        case name
        case entries
        case allowsMultipleSelections = "isMultiSelect"
    }

    init(from decoder: Swift.Decoder) throws {
        let filterContainer = try decoder.container(keyedBy: FilterCodingKeys.self)

        resourceId = try filterContainer.decode(String.self, forKey: .resourceId)
        name = try filterContainer.decode(String.self, forKey: .name)
        entries = try filterContainer.decodeIfPresent([FilterEntryType].self, forKey: .entries) ?? []
        allowsMultipleSelections = try filterContainer.decode(Bool.self, forKey: .allowsMultipleSelections)
    }

}
