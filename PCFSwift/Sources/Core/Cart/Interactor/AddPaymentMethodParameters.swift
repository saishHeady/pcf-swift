//
//  AddPaymentMethodParameters.swift
//  PCFSwift
//
//  Created by Thibault Klein on 10/31/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

/// Data transfer object to add a payment method to the cart.
public struct AddPaymentMethodParameters: ParameterConvertible {

    /// The payment method type.
    let type: String

    /// The payment object.
    let paymentObject: AddPaymentObjectParameters

    init(type: String, paymentObject: AddPaymentObjectParameters) {
        self.type = type
        self.paymentObject = paymentObject
    }

    public func toParameters() -> Parameters {
        return [
            "type": type,
            "paymentObject": paymentObject.toParameters()
        ]
    }

}
