//
//  Adjustment.swift
//  PCFSwift
//
//  Created by Satinder Singh on 7/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  Adjustment protocol.
 */
public protocol Adjustment {

    /// Identifier of the adjustment
    var resourceId: String { get }

    /// Description of the adjustment
    var adjustmentDescription: String? { get }

    /// Adjustment amount to be applied to the total
    var amount: Float { get }

    /// Adjustment code
    var code: String { get }

    /// Adjustment type e.g. coupon, giftcard, etc
    var type: String? { get }
}
