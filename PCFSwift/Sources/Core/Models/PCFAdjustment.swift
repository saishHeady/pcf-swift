//
//  PCFAdjustment.swift
//  PCFSwift
//
//  Created by Satinder Singh on 7/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  PCFAdjustment model.
 */
public struct PCFAdjustment: Adjustment, Swift.Decodable {

    /// Identifier of the adjustment
    public let resourceId: String

    /// Description of the adjustment
    public let adjustmentDescription: String?

    /// Adjustment amount to be applied to the total
    public let amount: Float

    /// Adjustment code
    public let code: String

    /// Adjustment type e.g. coupon, giftcard, etc
    public let type: String?

}

// MARK: - Swift.Decodable

public extension PCFAdjustment {

    private enum AdjustmentCodingKeys: String, CodingKey {
        case resourceId = "id"
        case adjustmentDescription = "description"
        case amount
        case code
        case type
    }

    init(from decoder: Swift.Decoder) throws {
        let adjustmentContainer = try decoder.container(keyedBy: AdjustmentCodingKeys.self)

        resourceId = try adjustmentContainer.decode(String.self, forKey: .resourceId)
        adjustmentDescription = try adjustmentContainer.decodeIfPresent(String.self, forKey: .adjustmentDescription)
        amount = try adjustmentContainer.decode(Float.self, forKey: .amount)
        code = try adjustmentContainer.decode(String.self, forKey: .code)
        type = try adjustmentContainer.decodeIfPresent(String.self, forKey: .type)
    }

}
