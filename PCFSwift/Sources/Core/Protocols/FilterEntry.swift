//
//  FilterEntry.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  Filter entry protocol.
 */
public protocol FilterEntry {

    associatedtype ImageResourceType: ImageResource

    /// The filter entry value.
    var value: String { get }

    /// The filter entry label.
    var label: String { get }

    /// The filter entry quantity.
    var quantity: Int { get }

    /// The filter entry hex value.
    var hex: String? { get }

    /// The filter entry image information
    var imagePattern: ImageResourceType? { get }

    /// Indicates if the filter is selected.
    var isSelected: Bool { get }

}
