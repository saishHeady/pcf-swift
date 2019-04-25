//
//  SetCartShippingOptionParameters.swift
//  PCFSwift
//
//  Created by Harlan Kellaway on 9/26/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Data transfer object to add a shipping method to cart for an update cart HTTP request.
public struct SetCartShippingOptionParameters: ParameterConvertible {

    // MARK: - Properties

    /// The shipping option id.
    public let shippingOptionId: String

    // MARK: - Init/Deinit

    /// Creates new instance.
    ///
    /// - Parameter shippingOptionId: Shipping Option Id.
    public init(shippingOptionId: String) {
        self.shippingOptionId = shippingOptionId
    }

    // MARK: - Protocol conformance

    // MARK: ParameterConvertible

    public func toParameters() -> Parameters {
        return [
            "id": shippingOptionId
        ]
    }
}
