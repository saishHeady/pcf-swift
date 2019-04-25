//
//  UpdateCartParameters.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Data transfer object to update a cart item for an update cart HTTP request.
public struct UpdateCartParameters: ParameterConvertible, Equatable {

    /// The product id to add to cart.
    let productId: String
    /// The quantity to add to cart.
    let quantity: Int

    /// Default initializer for an update cart item data transfer object.
    ///
    /// - Parameters:
    ///   - productId: The product id to use.
    ///   - quantity: The quantity to add.
    public init(productId: String, quantity: Int) {
        self.productId = productId
        self.quantity = quantity
    }

    public func toParameters() -> Parameters {
        return [
            "id": productId,
            "quantity": quantity
        ]
    }

}

public func == (lhs: UpdateCartParameters, rhs: UpdateCartParameters) -> Bool {
    return lhs.productId == rhs.productId && lhs.quantity == rhs.quantity
}
