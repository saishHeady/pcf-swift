//
//  PCFCartShipment.swift
//  PCFSwift
//
//  Created by Harlan Kellaway on 9/26/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

/// PCFCartShipment model.
public struct PCFCartShipment: CartShipment, Swift.Decodable {

    public typealias AddressType = PCFAddress
    public typealias ShippingOptionType = PCFShippingOption

    /// Unique identifier for the shipment.
    public let resourceId: String

    /// Shipping Address for the shipment.
    public let shippingAddress: AddressType?

    /// Shipping option for the shipment.
    public let shippingOption: ShippingOptionType?

}

// MARK: - Swift.Decodable

public extension PCFCartShipment {

    private enum CartShipmentCodingKeys: String, CodingKey {
        case resourceId = "id"
        case shippingAddress
        case shippingOption
    }

    init(from decoder: Swift.Decoder) throws {
        let cartShipmentContainer = try decoder.container(keyedBy: CartShipmentCodingKeys.self)

        resourceId = try cartShipmentContainer.decode(String.self, forKey: .resourceId)
        shippingAddress = try cartShipmentContainer.decodeIfPresent(AddressType.self, forKey: .shippingAddress)
        shippingOption = try cartShipmentContainer.decodeIfPresent(ShippingOptionType.self, forKey: .shippingOption)
    }

}
