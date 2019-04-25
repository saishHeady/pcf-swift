//
//  Store.swift
//  PCFSwift
//
//  Created by Thibault Klein on 6/29/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import CoreLocation

/// The store protocol.
public protocol Store {

    associatedtype AddressType: Address

    /// The store id.
    var resourceId: String { get }

    /// The store name.
    var name: String { get }

    /// The store description.
    var description: String? { get }

    /// The store hours.
    var hours: String? { get }

    /// The store coordinate.
    var coordinate: CLLocationCoordinate2D { get }

    /// The store address.
    var address: AddressType { get }

}
