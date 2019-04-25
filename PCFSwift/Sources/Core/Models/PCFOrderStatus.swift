//
//  PCFOrderStatus.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/19/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  PCFOrderStatus model.
 */
public struct PCFOrderStatus: OrderStatus, Swift.Decodable {

    /// The status of the order.
    public let statusText: String

    /// The tracking number for the order. Will only be present after the order has shipped if at all.
    public let trackingNumber: String

    /// The estimated delivery date. Contains one date if status is delivered.
    /// Contains a date OR date range if status is different from delivered.
    public let deliveryDate: [Date]

    fileprivate static func dateFormatter() -> DateFormatter {
        let dateFormatter = PCFDateFormatter.sharedInstance
        dateFormatter.dateFormat = PCFOrderStatus.dateFormat
        return dateFormatter
    }

    /// String Format for Dates
    internal static let dateFormat = "yyyy-MM-DD"

}

// MARK: Swift.Decodable

public extension PCFOrderStatus {

    private enum OrderStatusCodingKeys: String, CodingKey {
        case statusText
        case trackingNumber
        case deliveryDate
    }

    public init(from decoder: Swift.Decoder) throws {
        let orderStatusContainer = try decoder.container(keyedBy: OrderStatusCodingKeys.self)

        statusText = try orderStatusContainer.decode(String.self, forKey: .statusText)
        trackingNumber = try orderStatusContainer.decode(String.self, forKey: .trackingNumber)

        let deliveryDateStrings = try orderStatusContainer.decode([String].self, forKey: .deliveryDate)
        let deliveryDateValues: [Date] = try deliveryDateStrings.map {
            guard let dateValue = PCFOrderStatus.dateFormatter().date(from: $0) else {
                throw Swift.DecodingError.typeMismatch(Date.self, DecodingError.Context(codingPath: [OrderStatusCodingKeys.deliveryDate],
                                                                                        debugDescription: "Unable to decode date"))
            }
            return dateValue
        }

        deliveryDate = deliveryDateValues
    }

}
