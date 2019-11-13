//
//  PCFOrderDetail.swift
//  PCFSwift
//
//  Created by Thibault Klein on 3/13/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// PCFOrderDetail model.
public struct PCFOrderDetail: OrderDetail, Swift.Decodable {

    public typealias AddressType = PCFAddress
    public typealias AdjustmentType = PCFAdjustment
    public typealias CartItemType = PCFCartItem
    public typealias OrderStatusType = PCFOrderStatus
    public typealias PaymentMethodType = PCFPaymentMethod
    public typealias ShippingOptionType = PCFShippingOption
    public typealias CartShipmentType = PCFCartShipment

    public let resourceId: String
    public let orderDate: Date
    public let lastUpdated: Date
    public let status: OrderStatusType?
    public let itemCount: Int
    public let itemTotalCount: Int
    public let subTotal: Float
    public let totalAdjustment: Float
    public let tax: Float
    public let total: Float
    public let items: [CartItemType]
    public let adjustments: [AdjustmentType]
    public var shipments: [CartShipmentType]
    public var paymentMethods: [PaymentMethodType]
    public var billingAddress: AddressType?

    fileprivate static func dateFormatter() -> DateFormatter {
        let dateFormatter = PCFDateFormatter.sharedInstance
        dateFormatter.dateFormat = PCFOrderDetail.dateFormat
        return dateFormatter
    }

    /// String Format for Dates
    internal static let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

}

// MARK: - Swift.Decodable

public extension PCFOrderDetail {

    private enum OrderDetailCodingKeys: String, CodingKey {
        case resourceId = "id"
        case orderDate
        case lastUpdated
        case status
        case itemCount
        case itemTotalCount
        case subTotal
        case totalAdjustment
        case tax
        case total
        case items = "orderItems"
        case adjustments
        case shipments
        case paymentMethods
        case billingAddress
    }

    init(from decoder: Swift.Decoder) throws {
        let orderDetailContainer = try decoder.container(keyedBy: OrderDetailCodingKeys.self)

        resourceId = try orderDetailContainer.decode(String.self, forKey: .resourceId)

        let orderDateString = try orderDetailContainer.decode(String.self, forKey: .orderDate)
        guard let orderDateValue = PCFOrderDetail.dateFormatter().date(from: orderDateString) else {
            throw Swift.DecodingError.typeMismatch(Date.self,
                                                   DecodingError.Context(codingPath: [OrderDetailCodingKeys.orderDate],
                                                                         debugDescription: "Unable to decode date"))
        }

        orderDate = orderDateValue

        let lastUpdatedString = try orderDetailContainer.decode(String.self, forKey: .lastUpdated)
        guard let lastUpdatedValue = PCFOrderDetail.dateFormatter().date(from: lastUpdatedString) else {
            throw Swift.DecodingError.typeMismatch(Date.self,
                                                   DecodingError.Context(codingPath: [OrderDetailCodingKeys.lastUpdated],
                                                                                    debugDescription: "Unable to decode date"))
        }

        lastUpdated = lastUpdatedValue

        status = try orderDetailContainer.decodeIfPresent(PCFOrderStatus.self, forKey: .status)
        itemCount = try orderDetailContainer.decode(Int.self, forKey: .itemCount)
        itemTotalCount = try orderDetailContainer.decode(Int.self, forKey: .itemTotalCount)
        subTotal = try orderDetailContainer.decode(Float.self, forKey: .subTotal)
        totalAdjustment = try orderDetailContainer.decode(Float.self, forKey: .totalAdjustment)
        tax = try orderDetailContainer.decode(Float.self, forKey: .tax)
        total = try orderDetailContainer.decode(Float.self, forKey: .total)
        items = try orderDetailContainer.decodeIfPresent([CartItemType].self, forKey: .items) ?? []
        adjustments = try orderDetailContainer.decodeIfPresent([AdjustmentType].self, forKey: .adjustments) ?? []
        shipments = try orderDetailContainer.decodeIfPresent([CartShipmentType].self, forKey: .shipments) ?? []
        paymentMethods = try orderDetailContainer.decodeIfPresent([PaymentMethodType].self, forKey: .paymentMethods) ?? []
        billingAddress = try orderDetailContainer.decodeIfPresent(AddressType.self, forKey: .billingAddress)
    }

}
