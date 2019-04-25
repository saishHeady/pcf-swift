//
//  CartItem.swift
//  PCFSwift
//
//  Created by Satinder Singh on 7/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  CartItem protocol.
 */
public protocol CartItem {

    associatedtype AdjustmentType: Adjustment
    associatedtype PersonalizationOptionType: PersonalizationOption
    associatedtype ProductType: Product
    associatedtype SkuType: Sku

    /// Adjustments made specific to the product in this cart item.
    var adjustments: [AdjustmentType] { get }

    /// Denotes whether or not other SKUs of the product are available
    var otherSKUsAvailable: Bool? { get }

    /// Personalization Selections
    var personalizations: [PersonalizationOptionType]? { get }

    /// Minified product without SKU options or description.
    var product: ProductType { get }

    /// Quantity of product.
    var quantity: Int { get }

    /// Unique ID of the card item.
    var resourceId: String { get }

    /// values of the selected SKU
    var sku: SkuType? { get }

    /// Product discounted price times quantity.
    var totalDiscountedPrice: Float? { get }

    /// Product price times quantity
    var totalPrice: Float { get }

}
