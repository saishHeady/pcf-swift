//
//  ShippingOption.swift
//  PCFSwift
//
//  Created by Satinder Singh on 7/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  ShippingOption protocol
 */
public protocol ShippingOption {

    /// Id of shipping option
    var resourceId: String { get }

    /// Name of shipping option
    var name: String { get }

    // Price of shipping option
    var price: Float { get }
}
