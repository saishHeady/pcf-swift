//
//  Country.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/21/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  Country protocol.
 */
public protocol Country {

    /// The id or code for the region.
    var resourceId: String { get }

    /// The display name of the region.
    var name: String { get }

}
