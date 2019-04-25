//
//  AddToCartShippingAddressParameters.swift
//  PCFSwift
//
//  Created by Harlan Kellaway on 9/26/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Data transfer object to add a shipping address to cart for an update cart HTTP request.
public struct AddToCartAddressParameters: ParameterConvertible {

    /// The first name.
    let firstName: String?

    /// The last name.
    let lastName: String?

    /// The address 1.
    let address1: String

    /// The address 2.
    let address2: String?

    /// The city.
    let city: String

    /// The state.
    let state: String?

    /// The zip code.
    let zip: String

    /// Country.
    let country: String

    /// The phone number.
    let phone: String?

    /// The save value.
    let save: Bool

    /// Convenience initializer for an add to cart shipping address data transfer object.
    ///
    /// - Parameter address: The address to use.
    public init(address: Address) {
        self.init(firstName: address.firstName,
                  lastName: address.lastName,
                  address1: address.address1,
                  address2: address.address2,
                  city: address.city,
                  state: address.state,
                  zip: address.zip,
                  country: address.country,
                  phone: address.phone,
                  save: address.save)
    }

    /// Default initializer for an add to cart shipping address data transfer object.
    ///
    /// - Parameters:
    ///   - firstName: The first name to use.
    ///   - lastName: The last name to use.
    ///   - address1: The address 1 to use.
    ///   - address2: The address 2 to use.
    ///   - city: The city to use.
    ///   - state: The state to use.
    ///   - zip: The zip to use.
    ///   - country: The country to use.
    ///   - phone: The phone to use.
    ///   - save: The save value to use.
    public init(firstName: String?,
                lastName: String?,
                address1: String,
                address2: String?,
                city: String,
                state: String?,
                zip: String,
                country: String,
                phone: String?,
                save: Bool) {
        self.firstName = firstName
        self.lastName = lastName
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.state = state
        self.zip = zip
        self.country = country
        self.phone = phone
        self.save = save
    }

    public func toParameters() -> Parameters {
        var parameters: Parameters = [
            "address1": address1,
            "city": city,
            "zip": zip,
            "country": country,
            "save": save
        ]

        if let firstName = firstName {
            parameters["firstName"] = firstName
        }

        if let lastName = lastName {
            parameters["lastName"] = lastName
        }

        if let address2 = address2 {
            parameters["address2"] = address2
        }

        if let state = state {
            parameters["state"] = state
        }

        if let phone = phone {
            parameters["phone"] = phone
        }

        return parameters
    }

}
