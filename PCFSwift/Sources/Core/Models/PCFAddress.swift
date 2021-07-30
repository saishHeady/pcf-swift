//
//  PCFAddress.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/20/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/// PCF address default model.
public struct PCFAddress: Address, Swift.Decodable {

    /// Unique identifier for the address.
    public let resourceId: String

    /// First name on the address.
    public let firstName: String?

    /// Last name on the address.
    public let lastName: String?

    /// First street address field.
    public let address1: String

    /// Second street address field.
    public let address2: String?

    /// City on address.
    public let city: String

    /// State (or region/province) on address.
    /// The recommendation for this value is for it to be a standard state/region/province abbreviation
    /// so that it can be used with the 'countries' endpoint, but implementations may vary depending on requirements.
    public let state: String?

    /// Country on address. The recommendation for this value is for it to be a standard country abbreviation
    /// so that it can be used with the 'countries' endpoint, but implementations may vary depending on requirements.
    public let country: String

    /// Postal code on address.
    public let zip: String

    /// Phone number associated with address.
    public let phone: String?

    /// Used by some endpoints to store the address as a resource that can be used later.
    public let save: Bool

    /// Indicates whether or not the address is the default address.
    public let isPrimary: Bool

    /// Initializes a PCF address.
    ///
    /// - Parameters:
    ///   - resourceId: The address resource id. Default value is an empty string.
    ///   - firstName: The address first name.
    ///   - lastName: The address last name.
    ///   - address1: The address line 1.
    ///   - address2: The address line 2. Default value is nil.
    ///   - city: The address city.
    ///   - state: The address state.
    ///   - country: The address country.
    ///   - zip: The address zip code.
    ///   - phone: The address phone number.
    ///   - save: `true` to save the address in the user's account.
    ///   - isPrimary: `true` to make the address the primary address.
    public init(resourceId: String = "",
                firstName: String? = nil,
                lastName: String? = nil,
                address1: String,
                address2: String? = nil,
                city: String,
                state: String? = nil,
                country: String,
                zip: String,
                phone: String? = nil,
                save: Bool,
                isPrimary: Bool) {
        self.resourceId = resourceId
        self.firstName = firstName
        self.lastName = lastName
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.state = state
        self.country = country
        self.zip = zip
        self.phone = phone
        self.save = save
        self.isPrimary = isPrimary
    }

}

// MARK: - Swift.Decodable

public extension PCFAddress {

    private enum AddressCodingKeys: String, CodingKey {
        case resourceId = "id"
        case firstName
        case lastName
        case address1
        case address2
        case city
        case state
        case country
        case zip
        case phone
        case save
        case isPrimary
    }

    init(from decoder: Swift.Decoder) throws {
        let addressContainer = try decoder.container(keyedBy: AddressCodingKeys.self)

        resourceId = try addressContainer.decode(String.self, forKey: .resourceId)
        firstName = try addressContainer.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try addressContainer.decodeIfPresent(String.self, forKey: .lastName)
        address1 = try addressContainer.decode(String.self, forKey: .address1)
        address2 = try addressContainer.decodeIfPresent(String.self, forKey: .address2)
        city = try addressContainer.decode(String.self, forKey: .city)
        state = try addressContainer.decodeIfPresent(String.self, forKey: .state)
        country = try addressContainer.decode(String.self, forKey: .country)
        zip = try addressContainer.decode(String.self, forKey: .zip)
        phone = try addressContainer.decodeIfPresent(String.self, forKey: .phone)
        save = try addressContainer.decodeIfPresent(Bool.self, forKey: .save) ?? false
        isPrimary = try addressContainer.decodeIfPresent(Bool.self, forKey: .isPrimary) ?? false

    }

}
