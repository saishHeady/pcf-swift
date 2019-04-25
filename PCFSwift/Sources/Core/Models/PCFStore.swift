//
//  PCFStore.swift
//  PCFSwift
//
//  Created by Thibault Klein on 6/29/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import CoreLocation

/// PCFStore model.
public struct PCFStore: Store, Swift.Decodable {

    public typealias AddressType = PCFAddress

    public let resourceId: String
    public let name: String
    public let description: String?
    public let hours: String?
    public let coordinate: CLLocationCoordinate2D
    public let address: AddressType

}

// MARK: - Swift.Decodable

public extension PCFStore {

    private enum StoreCodingKeys: String, CodingKey {
        case resourceId = "id"
        case name
        case description
        case hours
        case coordinate
        case address
    }

    private enum CoordinateCodingKeys: String, CodingKey {
        case latitude
        case longitude
    }

    public init(from decoder: Swift.Decoder) throws {
        let storeContainer = try decoder.container(keyedBy: StoreCodingKeys.self)

        resourceId = try storeContainer.decode(String.self, forKey: .resourceId)
        name = try storeContainer.decode(String.self, forKey: .name)
        description = try storeContainer.decodeIfPresent(String.self, forKey: .description)
        hours = try storeContainer.decodeIfPresent(String.self, forKey: .hours)
        address = try storeContainer.decode(AddressType.self, forKey: .address)

        let coordinateContainer = try storeContainer.nestedContainer(keyedBy: CoordinateCodingKeys.self, forKey: .coordinate)
        let latitude = try coordinateContainer.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try coordinateContainer.decode(CLLocationDegrees.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

    }

}
