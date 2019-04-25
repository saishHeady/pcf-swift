//
//  AddToCartParameters.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Data transfer object to add an item to cart for add to cart HTTP request.
public struct AddToCartParameters: ParameterConvertible {

    /// The product id to add to cart.
    let productId: String
    /// The quantity to add to cart.
    let quantity: Int
    /// The SKU id to add to cart.
    let skuId: String
    /// The personalization options to add to cart.
    let personalizations: [AddToCartPersonalizationsParameters]
    /// The customerId
    let customerId: String?
			
    /// Default initializer for an add to cart data transfer object.
    ///
    /// - Parameters:
    ///   - productId: The product id to use.
    ///   - quantity: The quantity to add.
    ///   - skuId: The SKU id to use.
    ///   - personalizations: The personalization options to add.
    ///   - customerId: The customer ID
    public init(productId: String,
                quantity: Int,
                skuId: String,
                personalizations: [AddToCartPersonalizationsParameters],
                customerId: String = "") {
        self.productId = productId
        self.quantity = quantity
        self.skuId = skuId
        self.personalizations = personalizations
        self.customerId = customerId
    }

    public func toParameters() -> Parameters {
        return [
            "product": ["id": productId],
            "quantity": quantity,
            "sku": ["id": skuId],
            "personalizations": personalizations.map { $0.toParameters() },
            "customerId": customerId
        ]
    }

}
