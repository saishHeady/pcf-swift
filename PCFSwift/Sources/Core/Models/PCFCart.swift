//
//  PCFCart.swift
//  PCFSwift
//
//  Created by Satinder Singh on 7/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  PCFCart model.
 */
public struct PCFCart: Cart, Swift.Decodable {

    public typealias AddressType = PCFAddress
    public typealias AdjustmentType = PCFAdjustment
    public typealias CartItemType = PCFCartItem
    public typealias CartShipmentType = PCFCartShipment
    public typealias PaymentMethodType = PCFPaymentMethod
    public typealias CustomerInformationType = PCFCustomerInformation

    public let adjustments: [AdjustmentType]
    public let billingAddress: AddressType?
    public let cartItems: [CartItemType]
    public let costUntilFreeShipping: Float?
    public let itemCount: Int
    public let itemTotalCount: Int
    public let shipments: [CartShipmentType]
    public let paymentMethods: [PaymentMethodType]
    public let subtotal: Float
    public let tax: Float?
    public let totalAdjustment: Float
    public let total: Float?
    public let customerInformation: CustomerInformationType?
    public let stateTax: Float?
    public let stateTaxLabel: String?

    // MARK: - Init/Deinit

    public init(adjustments: [AdjustmentType],
                billingAddress: AddressType?,
                cartItems: [CartItemType],
                costUntilFreeShipping: Float?,
                itemCount: Int,
                itemTotalCount: Int,
                shipments: [CartShipmentType],
                paymentMethods: [PaymentMethodType],
                subtotal: Float,
                tax: Float?,
                totalAdjustment: Float,
                total: Float?,
                customerInformation: CustomerInformationType?,
                stateTax: Float?,
                stateTaxLabel: String?) {
        self.adjustments = adjustments
        self.billingAddress = billingAddress
        self.cartItems = cartItems
        self.costUntilFreeShipping = costUntilFreeShipping
        self.itemCount = itemCount
        self.itemTotalCount = itemTotalCount
        self.shipments = shipments
        self.paymentMethods = paymentMethods
        self.subtotal = subtotal
        self.tax = tax
        self.totalAdjustment = totalAdjustment
        self.total = total
        self.customerInformation = customerInformation
        self.stateTax = stateTax
        self.stateTaxLabel = stateTaxLabel
    }

    // MARK: - Protocol conformance

    // MARK: Cart

    /// Convenience method to find CartItem with provided SKU ID.
    ///
    /// - Parameter skuId: SKU ID of cart item to find.
    /// - Returns: Cart item if single cart item found with provided SKU. Nil not found or multiple found.
    public func cartItem(forSKU skuId: String) -> PCFCartItem? {
        var cartItemsWithSKU: [PCFCartItem] = []

        for cartItem in cartItems where cartItem.sku?.resourceId == skuId {
            cartItemsWithSKU.append(cartItem)
        }

        guard cartItemsWithSKU.count == 1 else {
            return nil
        }

        return cartItemsWithSKU[0]
    }

    /// Convenience method to find all payment methods of type credit card
    /// associated with the cart.
    ///
    /// - Returns: Credit cards associated with the cart.
    public func paymentMethods(ofType type: String) -> [PCFPaymentMethod] {
        return paymentMethods.filter { $0.type == type }
    }

}

// MARK: - Swift.Decodable

public extension PCFCart {

    private enum CartCodingKeys: String, CodingKey {
        case adjustments
        case billingAddress
        case cartItems
        case costUntilFreeShipping
        case itemCount
        case itemTotalCount
        case shipments
        case paymentMethods
        case subtotal = "subTotal"
        case tax
        case totalAdjustment
        case total
        case customerInformation
        case stateTax
        case stateTaxLabel
    }

    init(from decoder: Swift.Decoder) throws {
        let cartContainer = try decoder.container(keyedBy: CartCodingKeys.self)

        adjustments = try cartContainer.decodeIfPresent([AdjustmentType].self, forKey: .adjustments) ?? []
        billingAddress = try cartContainer.decodeIfPresent(AddressType.self, forKey: .billingAddress)
        cartItems = try cartContainer.decodeIfPresent([CartItemType].self, forKey: .cartItems) ?? []
        costUntilFreeShipping = try cartContainer.decode(Float.self, forKey: .costUntilFreeShipping)
        itemCount = try cartContainer.decode(Int.self, forKey: .itemCount)
        itemTotalCount = try cartContainer.decode(Int.self, forKey: .itemTotalCount)
        shipments = try cartContainer.decodeIfPresent([CartShipmentType].self, forKey: .shipments) ?? []
        paymentMethods = try cartContainer.decodeIfPresent([PaymentMethodType].self, forKey: .paymentMethods) ?? []
        subtotal = try cartContainer.decode(Float.self, forKey: .subtotal)
        tax = try? cartContainer.decode(Float.self, forKey: .tax)
        totalAdjustment = try cartContainer.decode(Float.self, forKey: .totalAdjustment)
        total = try cartContainer.decodeIfPresent(Float.self, forKey: .total)
        customerInformation = try cartContainer.decodeIfPresent(CustomerInformationType.self, forKey: .customerInformation)
        stateTax = try? cartContainer.decode(Float.self, forKey: .stateTax)
        stateTaxLabel = try? cartContainer.decode(String.self, forKey: .stateTaxLabel)
    }

}
