//
//  Filter.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  Filter protocol.
 */
public protocol Filter {

    associatedtype FilterEntryType: FilterEntry

    /// The key used to make a search using this filter.
    var resourceId: String { get }

    /// The display name of the filter.
    var name: String { get }

    /// Filter entries.
    var entries: [FilterEntryType] { get }

    /// Whether or not the filter allows selecting multiple filter entries.
    var allowsMultipleSelections: Bool { get }

}
