//
//  Address.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/20/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  Address protocol.
 */
public protocol Address {

    /// Unique identifier for the address.
    var resourceId: String { get }

    /// First name on the address.
    var firstName: String? { get }

    /// Last name on the address.
    var lastName: String? { get }

    /// First street address field.
    var address1: String { get }

    /// Second street address field.
    var address2: String? { get }

    /// City on address.
    var city: String { get }

    /// State (or region/province) on address.
    /// The recommendation for this value is for it to be a standard state/region/province abbreviation
    /// so that it can be used with the 'countries' endpoint, but implementations may vary depending on requirements.
    var state: String? { get }

    /// Country on address. The recommendation for this value is for it to be a standard country abbreviation
    /// so that it can be used with the 'countries' endpoint, but implementations may vary depending on requirements.
    var country: String { get }

    /// Postal code on address.
    var zip: String { get }

    /// Phone number associated with address.
    var phone: String? { get }

    /// Used by some endpoints to store the address as a resource that can be used later.
    var save: Bool { get }

    /// Indicates whether or not the address is the default address.
    var isPrimary: Bool { get }

}
