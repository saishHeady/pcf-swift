//
//  Order.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/19/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  Order protocol.
 */
public protocol Order {

    associatedtype OrderStatusType: OrderStatus

    /// The order id.
    var resourceId: String { get }

    /// The order date.
    var orderDate: Date { get }

    /// The order last updated date.
    var lastUpdated: Date { get }

    /// The order status.
    var status: OrderStatusType { get }

    /// The order items count.
    var itemCount: Int { get }

    /// The order items total count.
    var itemTotalCount: Int { get }

    /// The order sub-total.
    var subTotal: Float { get }

    /// The order tax.
    var tax: Float { get }

    /// The order total adjustment.
    var totalAdjustment: Float { get }

    /// The order total.
    var total: Float { get }

}
