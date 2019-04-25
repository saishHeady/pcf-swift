//
//  PaymentMethod.swift
//  PCFSwift
//
//  Created by Daniel Vancura on 11/21/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/// Method to pay for an order.
public protocol PaymentMethod {

    /// The type used to represent this object's payment object.
    associatedtype PaymentObjectType: PaymentObject

    /// The payment method id.
    var resourceId: String { get }

    /// The payment method type.
    var type: String { get }

    /// The payment object used to perform the payment.
    var paymentObject: PaymentObjectType { get }

}
