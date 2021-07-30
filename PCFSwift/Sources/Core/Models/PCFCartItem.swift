//
//  PCFCartItem.swift
//  PCFSwift
//
//  Created by Satinder Singh on 7/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  PCFCartItem model.
 */
public struct PCFCartItem: CartItem, Swift.Decodable {

    public typealias AdjustmentType = PCFAdjustment
    public typealias PersonalizationOptionType = PCFPersonalizationOption
    public typealias ProductType = PCFProduct
    public typealias SkuType = PCFSku

    /// Adjustments made specific to the product in this cart item
    public let adjustments: [AdjustmentType]

    /// Denotes whether or not other SKUs of the product are available
    public let otherSKUsAvailable: Bool?

    /// Personalization Selections
    public let personalizations: [PersonalizationOptionType]?

    /// Minified product without SKU options or description.
    public let product: ProductType

    /// Quantity of product.
    public let quantity: Int

    /// Unique ID of the card item.
    public let resourceId: String

    /// values of the selected SKU
    public let sku: SkuType?

    /// Product discounted price times quantity.
    public let totalDiscountedPrice: Float?

    /// Product price times quantity
    public let totalPrice: Float

}

// MARK: - Swift.Decodable

public extension PCFCartItem {

    private enum CartItemCodingKeys: String, CodingKey {
        case adjustments
        case otherSKUsAvailable = "otherSkusAvailable"
        case personalizations
        case product
        case quantity
        case resourceId = "id"
        case sku
        case totalDiscountedPrice
        case totalPrice
    }

    init(from decoder: Swift.Decoder) throws {
        let cartItemContainer = try decoder.container(keyedBy: CartItemCodingKeys.self)

        adjustments = try cartItemContainer.decodeIfPresent([AdjustmentType].self, forKey: .adjustments) ?? []
        otherSKUsAvailable = try cartItemContainer.decodeIfPresent(Bool.self, forKey: .otherSKUsAvailable)
        personalizations = try cartItemContainer.decodeIfPresent([PersonalizationOptionType].self, forKey: .personalizations) ?? []
        product = try cartItemContainer.decode(ProductType.self, forKey: .product)
        quantity = try cartItemContainer.decode(Int.self, forKey: .quantity)
        resourceId = try cartItemContainer.decode(String.self, forKey: .resourceId)
        sku = try cartItemContainer.decodeIfPresent(SkuType.self, forKey: .sku)
        totalDiscountedPrice = try cartItemContainer.decodeIfPresent(Float.self, forKey: .totalDiscountedPrice)
        totalPrice = try cartItemContainer.decode(Float.self, forKey: .totalPrice)
    }

}
