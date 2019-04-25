//
//  OrderStatus.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/19/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  OrderStatus protocol.
 */
public protocol OrderStatus {

    /// The status of the order.
    var statusText: String { get }

    /// The tracking number for the order. Will only be present after the order has shipped if at all.
    var trackingNumber: String { get }

    /// The estimated delivery date. Contains one date if status is delivered.
    /// Contains a date OR date range if status is different from delivered.
    var deliveryDate: [Date] { get }

}
