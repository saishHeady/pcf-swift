//
//  PaymentObject.swift
//  PCFSwift
//
//  Created by Daniel Vancura on 11/21/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/// Represents means to pay for an order.
public protocol PaymentObject {

    /// The address type used in a `PaymentObject`.
    associatedtype AddressType: Address

    /// The last four digits of the card number if coming from order history (for instance "************1111").
    /// The full card number if coming from an user input field.
    /// A gift card number if the payment object is a gift card.
    var number: String { get }

    /// Debit/credit card only. The card type of the card.
    var cardType: String? { get }

    /// Debit/credit card only. The name of the card holder.
    var nameOnCard: String? { get }

    /// Debit/credit card only. The card expiration month.
    var expirationMonth: Int? { get }

    /// Debit/credit card only. The card expiration year.
    var expirationYear: Int? { get }

}
