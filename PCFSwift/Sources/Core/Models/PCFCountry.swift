//
//  PCFCountry.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/21/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  PCFCountry model.
 */
public struct PCFCountry: Country, Swift.Decodable {

    /// The id or code for the region.
    public let resourceId: String

    /// The display name of the region.
    public let name: String

}

// MARK: - Swift.Decodable

public extension PCFCountry {

    private enum CountryCodingKeys: String, CodingKey {
        case resourceId = "id"
        case name
    }

    init(from decoder: Swift.Decoder) throws {
        let countryContainer = try decoder.container(keyedBy: CountryCodingKeys.self)

        resourceId = try countryContainer.decode(String.self, forKey: .resourceId)
        name = try countryContainer.decode(String.self, forKey: .name)

    }

}
