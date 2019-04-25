//
//  Cart.swift
//  PCFSwift
//
//  Created by Satinder Singh on 7/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  Cart protocol.
 */
public protocol Cart {

    associatedtype AddressType: Address
    associatedtype AdjustmentType: Adjustment
    associatedtype CartItemType: CartItem
    associatedtype CartShipmentType: CartShipment
    associatedtype SkuType: Sku
    associatedtype ProductType: Product
    associatedtype PaymentMethodType: PaymentMethod
    associatedtype CustomerInformationType: CustomerInformation

    /// List of adjustments made to cart as a whole.
    var adjustments: [AdjustmentType] { get }

    /// Billing address associated with cart for checkout purposes.
    var billingAddress: AddressType? { get }

    /// List of Cart Items
    var cartItems: [CartItemType] { get }

    /// Amount customer must still spend in order to receive free shipping on this cart.
    var costUntilFreeShipping: Float? { get }

    /// Number of unique cart items.
    var itemCount: Int { get }

    /// Total number of items within cart.
    /// Represents the sum of the quantities for each cart item.
    var itemTotalCount: Int { get }

    /// List of shipments associated with cart for checkout purposes.
    var shipments: [CartShipmentType] { get }

    /// List of payment methods associated with the cart for checkout purposes.
    var paymentMethods: [PaymentMethodType] { get }

    /// Subtotal of purchase.
    var subtotal: Float { get }

    /// Total adjustments made to cart.
    var totalAdjustment: Float { get }

    /// Tax calculated for order.
    var tax: Float? { get }

    /// Final total after adjustments.
    var total: Float? { get }

    /**
     Convenience method to find quantity of SKU within cart

     - parameter sku: The SKU to find within cart

     - returns: Quantity for SKU within cart
     */
    func quantity(forProduct product: ProductType) -> Int

    /**
     Convenience method to find quantity of SKU within cart

     - parameter product: Product to find within cart.

     - returns: Quantity for product within cart
     */
    func quantity(forSKU sku: SkuType) -> Int

    /// Convenience method to find CartItem with provided SKU ID.
    ///
    /// - Parameter skuId: SKU Id of cart item to find.
    /// - Returns: Cart item if single cart item found with provided SKU. Nil if not found or multiple found.
    func cartItem(forSKU skuId: String) -> CartItemType?

}

// MARK: - Cart Extension Methods
extension Cart {
    /**
     Convenience method to find quantity of SKU within cart

     - parameter sku: The SKU to find within cart

     - returns: Quantity for SKU within cart
     */
    public func quantity(forSKU sku: PCFSku) -> Int {
        let filteredCartItems = cartItems.filter { $0.sku?.resourceId == sku.resourceId }
        return filteredCartItems.reduce(0) { $0 + $1.quantity }
    }

    /**
     Convenience method to find quantity of SKU within cart

     - parameter product: Product to find within cart.

     - returns: Quantity for product within cart
     */
    public func quantity(forProduct product: PCFProduct) -> Int {
        let filteredCartItems = cartItems.filter { $0.product.resourceId == product.resourceId }
        return filteredCartItems.reduce(0) { $0 + $1.quantity }
    }
}
