//
//  PCFShippingOption.swift
//  PCFSwift
//
//  Created by Satinder Singh on 7/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  PCFShippingOption model
 */
public struct PCFShippingOption: ShippingOption, Swift.Decodable {

    /// Id of shipping option
    public let resourceId: String

    /// Name of shipping option
    public let name: String

    // Price of shipping option
    public let price: Float

}

// MARK: - Swift.Decodable

public extension PCFShippingOption {

    private enum ShippingOptionCodingKeys: String, CodingKey {
        case resourceId = "id"
        case name
        case price
    }

    public init(from decoder: Swift.Decoder) throws {
        let shippingOptionContainer = try decoder.container(keyedBy: ShippingOptionCodingKeys.self)

        resourceId = try shippingOptionContainer.decode(String.self, forKey: .resourceId)
        name = try shippingOptionContainer.decode(String.self, forKey: .name)
        price = try shippingOptionContainer.decode(Float.self, forKey: .price)

    }

}
