//
//  LoggingCartInteractor.swift
//  PCFSwift
//
//  Created by Harlan Kellaway on 9/26/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation
import PCFSwift

/// Cart Interactor that logs values for testing purposes.
final class LoggingCartInteractor: CartInteractor<PCFCart, PCFOrderDetail, PCFShippingOption> {

    var wasUpdateCalled = false
    var parametersForUpdateCall: [ParameterConvertible] = []

    override open func update(items: [ParameterConvertible], completion: @escaping (PCFCart?, Swift.Error?) -> Void) {
        super.update(items: items) { [weak self] (cart, error) in
            self!.wasUpdateCalled = true
            self!.parametersForUpdateCall = items

            completion(cart, error)
        }
    }

}
