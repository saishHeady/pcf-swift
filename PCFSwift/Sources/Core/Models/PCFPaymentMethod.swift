//
//  PCFPaymentMethod.swift
//  PCFSwift
//
//  Created by Daniel Vancura on 11/21/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/// Method to pay for an order.
public struct PCFPaymentMethod: PaymentMethod, Swift.Decodable {

    public typealias PaymentObjectType = PCFPaymentObject

    public let resourceId: String
    public let type: String
    public let paymentObject: PaymentObjectType
    public let amount: Float?

    /// Initializes a payment method.
    ///
    /// - Parameters:
    ///   - type: The payment method type to use.
    ///   - paymentObject: The payment object to use.
    ///   - amount: The amount assigned to the payment method.
    public init(type: String,
                paymentObject: PaymentObjectType,
                amount: Float?) {
        self.init(resourceId: "",
                  type: type,
                  paymentObject: paymentObject,
                  amount: amount)
    }

    /// Initializes a payment method.
    ///
    /// - Parameters:
    ///   - resourceId: The resource id to use.
    ///   - type: The payment method type to use.
    ///   - paymentObject: The payment object to use.
    ///   - amount: The amount assigned to the payment method.
    public init(resourceId: String,
                type: String,
                paymentObject: PaymentObjectType,
                amount: Float?) {
        self.resourceId = resourceId
        self.type = type
        self.paymentObject = paymentObject
        self.amount = amount
    }

}

// MARK: - Swift.Decodable

public extension PCFPaymentMethod {

    private enum PaymentMethodCodingKeys: String, CodingKey {
        case resourceId = "id"
        case type
        case paymentObject
        case amount
    }

    init(from decoder: Swift.Decoder) throws {
        let paymentMethodContainer = try decoder.container(keyedBy: PaymentMethodCodingKeys.self)

        resourceId = try paymentMethodContainer.decode(String.self, forKey: .resourceId)
        type = try paymentMethodContainer.decode(String.self, forKey: .type)
        paymentObject = try paymentMethodContainer.decode(PaymentObjectType.self, forKey: .paymentObject)
        amount = try? paymentMethodContainer.decode(Float.self, forKey: .amount)
    }

}
