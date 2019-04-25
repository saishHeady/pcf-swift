//
//  CartShipment.swift
//  PCFSwift
//
//  Created by Harlan Kellaway on 9/26/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// CartShipment protocol.
public protocol CartShipment {

    associatedtype AddressType: Address
    associatedtype ShippingOptionType: ShippingOption

    /// Unique identifier for the shipment.
    var resourceId: String { get }

    /// Shipping Address for the shipment.
    var shippingAddress: AddressType? { get }

    /// Shipping option for the shipment.
    var shippingOption: ShippingOptionType? { get }

}
