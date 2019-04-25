//
//  PCFPaymentObject.swift
//  PCFSwift
//
//  Created by Daniel Vancura on 11/21/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/// Represents means to pay for an order.
public struct PCFPaymentObject: PaymentObject, Swift.Decodable {

    public typealias AddressType = PCFAddress
    public let number: String
    public let cardType: String?
    public let nameOnCard: String?
    public let expirationMonth: Int?
    public let expirationYear: Int?

    /// Initializes a payment object.
    ///
    /// - Parameters:
    ///   - number: The payment object number to use.
    ///   - cardType: Debit/credit card only. The card type to use.
    ///   - nameOnCard: Debit/credit card only. The card holder name.
    ///   - expirationMonth: Debit/credit card only. The card expiration month.
    ///   - expirationYear: Debit/credit card only. The card expiration year.
    public init(number: String,
                cardType: String?,
                nameOnCard: String?,
                expirationMonth: Int?,
                expirationYear: Int?) {
        self.number = number
        self.cardType = cardType
        self.nameOnCard = nameOnCard
        self.expirationMonth = expirationMonth
        self.expirationYear = expirationYear
    }

}
