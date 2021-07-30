//
//  PCFOrder.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/19/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/// Global String Format for Dates.
/// This property is global allowing PCFSwift consumers to
/// use this format externally.
public let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

/**
 *  PCFOrder model.
 */
public struct PCFOrder: Order, Swift.Decodable {

    public typealias OrderStatusType = PCFOrderStatus

    /// The order id.
    public let resourceId: String

    /// The order date.
    public let orderDate: Date

    /// The order last updated date.
    public let lastUpdated: Date

    /// The order status.
    public let status: OrderStatusType

    /// The order items count.
    public let itemCount: Int

    /// The order items total count.
    public let itemTotalCount: Int

    /// The order sub-total.
    public let subTotal: Float

    /// The order tax.
    public let tax: Float

    /// The order total adjustment.
    public let totalAdjustment: Float

    /// The order total.
    public let total: Float

    fileprivate static func dateFormatter() -> DateFormatter {
        let dateFormatter = PCFDateFormatter.sharedInstance
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }

}

// MARK: - Swift.Decodable

public extension PCFOrder {

    private enum OrderCodingKeys: String, CodingKey {
        case resourceId = "id"
        case orderDate
        case lastUpdated
        case status
        case itemCount
        case itemTotalCount
        case subTotal
        case tax
        case totalAdjustment
        case total
    }

    init(from decoder: Swift.Decoder) throws {
        let orderContainer = try decoder.container(keyedBy: OrderCodingKeys.self)

        resourceId = try orderContainer.decode(String.self, forKey: .resourceId)

        let orderDateString = try orderContainer.decode(String.self, forKey: .orderDate)
        guard let orderDateValue = PCFOrder.dateFormatter().date(from: orderDateString) else {
            throw Swift.DecodingError.typeMismatch(Date.self, DecodingError.Context(codingPath: [OrderCodingKeys.orderDate],
                                                                                    debugDescription: "Unable to decode date"))
        }

        let lastUpdatedDateString = try orderContainer.decode(String.self, forKey: .lastUpdated)
        guard let lastUpdatedDateValue = PCFOrder.dateFormatter().date(from: lastUpdatedDateString) else {
            throw Swift.DecodingError.typeMismatch(Date.self, DecodingError.Context(codingPath: [OrderCodingKeys.lastUpdated],
                                                                                    debugDescription: "Unable to decode date"))
        }

        orderDate = orderDateValue
        lastUpdated = lastUpdatedDateValue
        status = try orderContainer.decode(OrderStatusType.self, forKey: .status)
        itemCount = try orderContainer.decode(Int.self, forKey: .itemCount)
        itemTotalCount = try orderContainer.decode(Int.self, forKey: .itemTotalCount)
        subTotal = try orderContainer.decode(Float.self, forKey: .subTotal)
        tax = try orderContainer.decode(Float.self, forKey: .tax)
        totalAdjustment = try orderContainer.decode(Float.self, forKey: .totalAdjustment)
        total = try orderContainer.decode(Float.self, forKey: .total)
    }

}
