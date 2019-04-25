//
//  OrderDetail.swift
//  PCFSwift
//
//  Created by Thibault Klein on 3/13/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// OrderDetail protocol.
public protocol OrderDetail {

    associatedtype AddressType: Address
    associatedtype AdjustmentType: Adjustment
    associatedtype CartItemType: CartItem
    associatedtype OrderStatusType: OrderStatus
    associatedtype PaymentMethodType: PaymentMethod
    associatedtype CartShipmentType: CartShipment

    /// The order detail resource id.
    var resourceId: String { get }

    /// The order date.
    var orderDate: Date { get }

    /// The last updated date.
    var lastUpdated: Date { get }

    /// The order status.
    var status: OrderStatusType? { get }

    /// The order item count.
    var itemCount: Int { get }

    /// The order item total count.
    var itemTotalCount: Int { get }

    /// The order subtotal.
    var subTotal: Float { get }

    /// The order total adjustments.
    var totalAdjustment: Float { get }

    /// The order tax calculation.
    var tax: Float { get }

    /// The order final total after adjustments.
    var total: Float { get }

    /// The order items.
    var items: [CartItemType] { get }

    /// List of shipments associated with the order.
    var shipments: [CartShipmentType] { get }

    /// List of payment methods associated with the order.
    var paymentMethods: [PaymentMethodType] { get }

    /// The order adjustments.
    var adjustments: [AdjustmentType] { get }

    /// Billing address associated with the order.
    var billingAddress: AddressType? { get }

}
