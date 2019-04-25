//
//  SortOption.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  Sort option protocol.
 */
public protocol SortOption {

    /// The label for the sort option.
    var label: String { get }

    /// The arrangement type/category for the sort option e.g. 'popularity'.
    var sort: String { get }

    /// The arrangement for the sort option e.g. 'desc'.
    var order: String { get }

    /// Indicates if the sort option is selected.
    var isSelected: Bool { get }

}
