//
//  AddPaymentObjectParameters.swift
//  PCFSwift
//
//  Created by Thibault Klein on 10/31/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

/// Data transfer object to add a payment object to cart.
public struct AddPaymentObjectParameters: ParameterConvertible {

    /// The payment object number.
    public let number: String

    /// The payment object card type.
    public let cardType: String?

    /// The payment object name on card.
    public let nameOnCard: String?

    /// The payment object expiration month.
    public let expirationMonth: Int?

    /// The payment object expiration year.
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

    public func toParameters() -> Parameters {
        var parameters: Parameters = ["number": number]

        if let cardType = cardType,
            let nameOnCard = nameOnCard,
            let expirationMonth = expirationMonth,
            let expirationYear = expirationYear {
            parameters = parameters.combineWith(
                ["cardType": cardType,
                 "nameOnCard": nameOnCard,
                 "expirationMonth": expirationMonth,
                 "expirationYear": expirationYear]
            )
        }

        return parameters
    }

}
