//
//  CartInteractor.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Default PCF cart interactor.
open class CartInteractor<CartType: Cart & Swift.Decodable, OrderDetailType: OrderDetail & Swift.Decodable, ShippingOptionType: ShippingOption & Swift.Decodable> {

    public let dataManager: CartDataManager<CartType, OrderDetailType, ShippingOptionType>
    public var cart: CartType?

    /// Creates a PCFCartInteractor with the given data manager.
    ///
    /// - Parameter dataManager: The data manager used for network communication.
    public init(dataManager: CartDataManager<CartType, OrderDetailType, ShippingOptionType>) {
        self.dataManager = dataManager
    }

    // MARK: - Data Functions

    /// Gets the cart.
    ///
    /// - Parameter completion: The completion block.
    open func cart(completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        dataManager.cart { [weak self] (cart, error) in
            self?.handleCartDataManagerResponse(cart: cart, error: error, completion: completion)
        }
    }

    /// Adds the given product to the cart.
    ///
    /// - Parameters:
    ///   - item: The item.
    ///   - completion: The completion block.
    open func add(item: ParameterConvertible,
                  completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        dataManager.add(items: [item]) { [weak self] (cart, error) in
            self?.handleCartDataManagerResponse(cart: cart, error: error, completion: completion)
        }
    }

    /// Adds the given products to the cart.
    ///
    /// - Parameters:
    ///   - items: The cart items to add.
    ///   - completion: The completion block.
    open func add(items: [ParameterConvertible],
                  completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        dataManager.add(items: items) { [weak self] (cart, error) in
            self?.handleCartDataManagerResponse(cart: cart, error: error, completion: completion)
        }
    }

    /// Updates the given product in the cart.
    ///
    /// - Parameters:
    ///   - items: The cart item to update.
    ///   - completion: The completion block.
    open func update(item: ParameterConvertible,
                     completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        dataManager.update(items: [item]) { [weak self] (cart, error) in
            self?.handleCartDataManagerResponse(cart: cart, error: error, completion: completion)
        }
    }

    /// Updates the given products to the cart.
    ///
    /// - Parameters:
    ///   - items: The cart items to update.
    ///   - completion: The completion block.
    open func update(items: [ParameterConvertible],
                     completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        dataManager.update(items: items) { [weak self] (cart, error) in
            self?.handleCartDataManagerResponse(cart: cart, error: error, completion: completion)
        }
    }

    /// Removes the product specified by the ID from the cart.
    ///
    /// - Parameters:
    ///   - itemId: The item to remove.
    ///   - completion: The completion block.
    open func removeItem(_ itemId: String,
                         completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        let removeItemParameters = UpdateCartParameters(productId: itemId, quantity: 0)
        update(items: [removeItemParameters]) { [weak self] (cart, error) in
            self?.handleCartDataManagerResponse(cart: cart, error: error, completion: completion)
        }
    }

    /// Updates the cart with the given adjustment object (gift card, promo code, coupon...)
    ///
    /// - Parameters:
    ///   - type: The type of adjustment.
    ///   - code: The code of the adjustment.
    ///   - completion: The completion block.
    open func adjustment(type: String, code: String,
                         completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        dataManager.adjustment(type: type, code: code) { [weak self] (cart, error) in
            self?.handleCartDataManagerResponse(cart: cart, error: error, completion: completion)
        }
    }

    /// Removes the given adjustment from the cart.
    ///
    /// - Parameters:
    ///   - code: The code of the adjustment.
    ///   - completion: The completion block.
    open func removeAdjustment(code: String,
                               completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        dataManager.removeAdjustment(code: code, completion: completion)
    }

    /// Updates the cart by adding the provided shipping address.
    ///
    /// - Parameters:
    ///   - shippingAddress: The shipping address.
    ///   - shipmentId: The shipment id to add the address to.
    ///   - useAsBillingAddress: Whether the shipping address should also be used for billing.
    ///   - completion: The completion block.
    open func addShippingAddress(_ shippingAddress: Address,
                                 toShipment shipmentId: String,
                                 useAsBillingAddress: Bool,
                                 completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        let shippingAddressParameters = AddToCartAddressParameters(address: shippingAddress)
        dataManager.addShippingAddress(shippingAddressParameters,
                                       toShipment: shipmentId,
                                       useAsBillingAddress: useAsBillingAddress) { [weak self] (cart, error) in
                                        self?.handleCartDataManagerResponse(cart: cart, error: error, completion: completion)
        }
    }

    /// Updates the cart by adding an existing shipping address by id.
    ///
    /// - Parameters:
    ///   - addressId: The id of the shipping address to add.
    ///   - shipmentId: The shipment id to add the address to.
    ///   - useAsBillingAddress: Whether the shipping address should also be used for billing.
    ///   - completion: The completion block.
    open func addShippingAddress(byID addressId: String,
                                 forShipment shipmentId: String,
                                 useAsBillingAddress: Bool,
                                 completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        dataManager.addShippingAddress(byId: addressId,
                                       forShipment: shipmentId,
                                       useAsBillingAddress: useAsBillingAddress) { [weak self] (cart, error) in
                                        self?.handleCartDataManagerResponse(cart: cart, error: error, completion: completion)
        }
    }

    /// Upates the cart by adding the provided billing address.
    ///
    /// - Parameters:
    ///   - billingAddress: The billing address.
    ///   - useAsShippingAddress: Whether ther billing address should also be used for shipping.
    ///   - completion: The completion block.
    open func addBillingAddress(_ billingAddress: Address,
                                useAsShippingAddress: Bool,
                                completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        let billingAddressParameters = AddToCartAddressParameters(address: billingAddress)
        dataManager.addBillingAddress(billingAddressParameters,
                                      useAsShippingAddress: useAsShippingAddress) { [weak self] (cart, error) in
                                        self?.handleCartDataManagerResponse(cart: cart, error: error, completion: completion)
        }
    }

    /// Updates the cart by adding an existing billing address by id.
    ///
    /// - Parameters:
    ///   - billingAddress: The id of the billing address to add.
    ///   - useAsShippingAddress: Whether ther billing address should also be used for shipping.
    ///   - completion: The completion block.
    open func addBillingAddress(byID addressId: String,
                                useAsShippingAddress: Bool,
                                completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        dataManager.addBillingAddress(byId: addressId,
                                      useAsShippingAddress: useAsShippingAddress) { [weak self] (cart, error) in
                                        self?.handleCartDataManagerResponse(cart: cart, error: error, completion: completion)
        }
    }

    /// Updates the cart by setting the shipping option for the provided shipment.
    ///
    /// - Parameters:
    ///   - shippingOptionId: The Id of the shipping option to use.
    ///   - shipmentId: The shipment id to set the shipping option for.
    ///   - completion: The completion block.
    open func setShippingOption(_ shippingOptionId: String,
                                forShipment shipmentId: String,
                                completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        let shippingOptionParameters = SetCartShippingOptionParameters(shippingOptionId: shippingOptionId)
        dataManager.setShippingOption(shippingOptionParameters,
                                      forShipment: shipmentId) { [weak self] (cart, error) in
                                        self?.handleCartDataManagerResponse(cart: cart, error: error, completion: completion)
        }
    }

    // swiftlint:disable line_length

    /// Gets the available shipping options for the current cart.
    ///
    /// - Parameters:
    ///   - shipmentId: The shipment id to get the shipping option for.
    ///   - completion: The completion block.
    open func shippingOptions(shipmentId: String,
                              completion: @escaping (_ shippingOptions: [ShippingOptionType], _ error: Swift.Error?) -> Void) {
        dataManager.shippingOptions(shipmentId: shipmentId, completion: completion)
    }

    /// Adds a new payment method to the cart.
    ///
    /// - Parameters:
    ///   - paymentMethod: The payment method to add.
    ///   - completion: The completion block.
    open func addPaymentMethod(_ paymentMethod: ParameterConvertible,
                               completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        dataManager.addPaymentMethod(paymentMethod) { [weak self] (cart, error) in
            self?.handleCartDataManagerResponse(cart: cart, error: error, completion: completion)
        }
    }

    /// Adds an existing payment method to the cart.
    ///
    /// - Parameters:
    ///   - paymentMethodId: The payment method to add by id.
    ///   - completion: The completion block.
    open func addPaymentMethod(byId paymentMethodId: String,
                               completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        dataManager.addPaymentMethod(byId: paymentMethodId) { [weak self] (cart, error) in
            self?.handleCartDataManagerResponse(cart: cart, error: error, completion: completion)
        }
    }

    /// Places order with the cart.
    ///
    /// - Parameter completion: The completion block.
    open func placeOrder(completion: @escaping (_ cart: OrderDetailType?, _ error: Swift.Error?) -> Void) {
        dataManager.placeOrder(completion: completion)
    }

    // MARK: - Business Logic Functions

    /// Convenience method to find all payment methods of type credit card
    /// associated with the cart.
    ///
    /// - Returns: Credit cards associated with the cart.
    public func paymentMethods(ofType type: String) -> [CartType.PaymentMethodType] {
        guard let cart = cart else {
            return []
        }

        return cart.paymentMethods.filter { $0.type == type }
    }

    // MARK: - Private Functions

    private func handleCartDataManagerResponse(cart: CartType?,
                                               error: Swift.Error?,
                                               completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        if let cart = cart {
            self.cart = cart
        }
        completion(cart, error)
    }

}
