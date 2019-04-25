//
//  CartDataManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/4/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Default cart data manager for the standard PCF cart.
open class CartDataManager<CartType: Cart & Swift.Decodable, OrderDetailType: OrderDetail & Swift.Decodable, ShippingOptionType: ShippingOption & Swift.Decodable>: DataManager {

    public let environmentManager: HTTPEnvironmentManager
    public let httpClient: HTTPClient
    public let sessionManager: SessionManager
    public var decoder: JSONDecoder

    /// Initializes a cart data manager.
    ///
    /// - Parameters:
    ///   - environmentManager: The environment manager to use.
    ///   - sessionManager: The session manager to use in case the session expired.
    ///   - httpClient: The HTTP client to use.
    ///   - decoder: decoder used to decode underlying JSON models
    public init(environmentManager: HTTPEnvironmentManager,
                sessionManager: SessionManager,
                httpClient: HTTPClient,
                decoder: JSONDecoder = JSONDecoder()) {
        self.environmentManager = environmentManager
        self.sessionManager = sessionManager
        self.httpClient = httpClient
        self.decoder = decoder
    }

    /// The API path to use.
    open var path: String {
        return "/cart"
    }

    /// Gets the cart.
    ///
    /// - Parameter completion: The completion block.
    open func cart(completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        let request = getCartRequest()
        perform(request: request, completion: completion)
    }

    /// Adds the given products to the cart.
    ///
    /// - Parameters:
    ///   - items: The cart items to add.
    ///   - completion: The completion block.
    open func add(items: [ParameterConvertible],
                  completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        let path = addToCartPath()
        let parameters = ["cartItems": items.map { $0.toParameters() }]
        let request = addToCartRequest(forPath: path, parameters: parameters)
        perform(request: request, completion: completion)
    }

    /// Updates the given products in the cart.
    ///
    /// - Parameters:
    ///   - items: The cart items to update.
    ///   - completion: The completion block.
    open func update(items: [ParameterConvertible],
                     completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        let path = updateCartPath()
        let parameters = ["cartItems": items.map { $0.toParameters() }]
        let request = updateCartRequest(forPath: path, parameters: parameters)
        perform(request: request, completion: completion)
    }

    /// Updates the cart with the given adjustment object (gift card, promo code, coupon...)
    ///
    /// - Parameters:
    ///   - type: The type of adjustment.
    ///   - code: The code of the adjustment.
    ///   - completion: The completion block.
    open func adjustment(type: String,
                         code: String,
                         completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        let request = applyAdjustmentRequest(type: type, code: code)
        perform(request: request, completion: completion)
    }

    /// Removes the given adjustment from the cart.
    ///
    /// - Parameters:
    ///   - code: The code of the adjustment.
    ///   - completion: The completion block.
    open func removeAdjustment(code: String,
                               completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        let request = removeAdjustmentRequest(code: code)
        perform(request: request, completion: completion)
    }

    /// Updates the cart by adding the provided shipping address.
    ///
    /// - Parameters:
    ///   - shippingAddress: The shipping address.
    ///   - shipmentId: The shipment id to add the address to.
    ///   - useAsBillingAddress: Whether the shipping address should also be used for billing.
    ///   - completion: The completion block.
    open func addShippingAddress(_ shippingAddress: ParameterConvertible,
                                 toShipment shipmentId: String,
                                 useAsBillingAddress: Bool,
                                 completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        let request = addShippingAddressToCartRequest(shipmentId: shipmentId,
                                                      shippingAddress: shippingAddress,
                                                      useAsBillingAddress: useAsBillingAddress)
        perform(request: request, completion: completion)
    }

    /// Updates the cart by adding an existing shipping address by id.
    ///
    /// - Parameters:
    ///   - addressId: The id of the shipping address to add.
    ///   - shipmentId: The shipment id to add the address to.
    ///   - useAsBillingAddress: Whether the shipping address should also be used for billing.
    ///   - completion: The completion block.
    open func addShippingAddress(byId addressId: String,
                                 forShipment shipmentId: String,
                                 useAsBillingAddress: Bool,
                                 completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        let request = addShippingAddressToCartRequest(shipmentId: shipmentId,
                                                      addressId: addressId,
                                                      useAsBillingAddress: useAsBillingAddress)
        perform(request: request, completion: completion)
    }

    /// Updates the cart by adding the provided billing address.
    ///
    /// - Parameters:
    ///   - shippingAddress: The billing address.
    ///   - useAsShippingAddress: Whether the billing address should also be used for shipping.
    ///   - completion: The completion block.
    open func addBillingAddress(_ billingAddress: ParameterConvertible,
                                useAsShippingAddress: Bool,
                                completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        let request = addBillingAddressToCartRequest(billingAddress: billingAddress,
                                                     useAsShippingAddress: useAsShippingAddress)
        perform(request: request, completion: completion)
    }

    /// Updates the cart by adding an existing billing address by id.
    ///
    /// - Parameters:
    ///   - addressId: The id of the shipping address to add.
    ///   - useAsShippingAddress: Whether the billing address should also be used for shipping.
    ///   - completion: The completion block.
    open func addBillingAddress(byId addressId: String,
                                useAsShippingAddress: Bool,
                                completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        let request = addBillingAddressToCartRequest(addressId: addressId,
                                                     useAsShippingAddress: useAsShippingAddress)
        perform(request: request, completion: completion)
    }

    /// Updates the cart by setting the shipping option for the provided shipment.
    ///
    /// - Parameters:
    ///   - shippingOption: The shipping option to use.
    ///   - shipmentId: The shipment id to set the shipping option for.
    ///   - completion: The completion block.
    open func setShippingOption(_ shippingOption: ParameterConvertible,
                                forShipment shipmentId: String,
                                completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        let request = setShippingOptionForCartRequest(shipmentId: shipmentId, shippingOption: shippingOption)
        perform(request: request, completion: completion)
    }

    // swiftlint:disable line_length

    /// Gets the available shipping options for the current cart.
    ///
    /// - Parameters:
    ///   - shipmentId: The shipment id to get the shipping option for.
    ///   - completion: The completion block.
    open func shippingOptions(shipmentId: String,
                              completion: @escaping (_ shippingOptions: [ShippingOptionType], _ error: Swift.Error?) -> Void) {
        let path = shippingOptionsForCartPath(shipmentId: shipmentId)
        let request = shippingOptionsCartRequest(forPath: path)
        perform(request: request, completion: completion)
    }

    /// Updates the cart with a new payment method.
    ///
    /// - Parameters:
    ///   - paymentMethod: The payment method to add.
    ///   - completion: The completion block.
    open func addPaymentMethod(_ paymentMethod: ParameterConvertible,
                               completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        let request = addPaymentMethodToCartRequest(paymentMethod: paymentMethod)
        perform(request: request, completion: completion)
    }

    /// Updates the cart with an existing payment method.
    ///
    /// - Parameters:
    ///   - paymentMethodId: The payment method to add by id.
    ///   - completion: The completion block.
    open func addPaymentMethod(byId paymentMethodId: String,
                               completion: @escaping (_ cart: CartType?, _ error: Swift.Error?) -> Void) {
        let request = addPaymentMethodToCartRequest(paymentMethodId: paymentMethodId)
        perform(request: request, completion: completion)
    }

    /// Places an order with the cart.
    ///
    /// - Parameter completion: The completion block.
    open func placeOrder(completion: @escaping (_ orderDetail: OrderDetailType?, _ error: Swift.Error?) -> Void) {
        let request = placeOrderRequest()
        perform(request: request, completion: completion)
    }

    /// Returns the requst path to get the cart.
    ///
    /// - Returns: The request path.
    open func getCartPath() -> String {
        return path
    }

    /// Returns the requst path to add to the cart.
    ///
    /// - Returns: The request path.
    open func addToCartPath() -> String {
        return path
    }

    /// Returns the request path to update the cart.
    ///
    /// - Returns: The request path.
    open func updateCartPath() -> String {
        return path
    }

    /// Returns the request path to apply an adjustment to the cart.
    ///
    /// - Returns: Th request path.
    open func applyAdjustmentCartPath() -> String {
        return path
    }

    /// Returns the request path to remove an adjustment from cart.
    ///
    /// - Parameter code: The adjustment code.
    /// - Returns: The request path.
    open func removeAdjustmentCartPath(code: String) -> String {
        return path + "/adjustment/\(code)"
    }

    /// Returns the request path to add a shipping address to cart for a given shimpment id.
    ///
    /// - Parameter shipmentId: The shipment ID for the shipping addres.
    /// - Returns: The request path.
    open func addShippingAddressToCartPath(shipmentId: String) -> String {
        return "\(path)/shipments/\(shipmentId)/shipping_address"
    }

    /// Returns the request path to add a billing address to cart.
    ///
    /// - Returns: The rquest path.
    open func addBillingAddressToCartPath() -> String {
        return "\(path)/billing_address"
    }

    /// Returns the request path for setting a shipping option for the cart.
    ///
    /// - Parameter shipmentId: The shipment id for the the shipping option.
    /// - Returns: The request path.
    open func shippingOptionsForCartPath(shipmentId: String) -> String {
        return "\(path)/shipments/\(shipmentId)/shipping_options"
    }

    /// Returns the request path for adding a payment method to the cart.
    ///
    /// - Returns: The request path.
    open func addPaymentMethodToCartPath() -> String {
        return "\(path)/payment_methods"
    }

    /// Returns the request path for placing an order with the cart.
    ///
    /// - Returns: The request path.
    open func placeOrderPath() -> String {
        return "\(path)/place_order"
    }

    /// HTTP Request for retrieving the cart.
    ///
    /// - Returns: HTTP Request.
    public func getCartRequest() -> HTTPRequest {
        let request = HTTPRequest(method: .get,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: getCartPath(),
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: headers(forEnvironment: environmentManager.currentEnvironment))
        return request
    }

    /// HTTP Request for applying adjustment to the cart.
    ///
    /// - Parameters:
    ///   - type: Adjustment type.
    ///   - code: Adjustment code.
    /// - Returns: HTTP Request.
    public func applyAdjustmentRequest(type: String,
                                       code: String) -> HTTPRequest {
        let parameters: Parameters = [
            "code": code,
            "type": type
        ]
        let request = HTTPRequest(method: .post,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: applyAdjustmentCartPath(),
                                  queryItems: nil,
                                  parameters: parameters,
                                  headers: headers(forEnvironment: environmentManager.currentEnvironment))
        return request
    }

    /// HTTP Request for removing adjustment from the cart.
    ///
    /// - Parameter code: Adjustment code.
    /// - Returns: HTTP Request.
    public func removeAdjustmentRequest(code: String) -> HTTPRequest {
        let request = HTTPRequest(method: .delete,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: removeAdjustmentCartPath(code: code),
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: headers(forEnvironment: environmentManager.currentEnvironment))
        return request
    }

    /// HTTP Request for retrieving the cart.
    ///
    /// - Returns: HTTP Request.
    public func placeOrderRequest() -> HTTPRequest {
        let request = HTTPRequest(method: .post,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: placeOrderPath(),
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: headers(forEnvironment: environmentManager.currentEnvironment))
        return request
    }

    // MARK: Internal functions

    internal func addToCartRequest(forPath path: String, parameters: Parameters) -> HTTPRequest {
        let request = HTTPRequest(method: .post,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: path,
                                  queryItems: nil,
                                  parameters: parameters,
                                  headers: headers(forEnvironment: environmentManager.currentEnvironment))
        return request
    }

    internal func updateCartRequest(forPath path: String, parameters: Parameters) -> HTTPRequest {
        let request = HTTPRequest(method: .put,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: path,
                                  queryItems: nil,
                                  parameters: parameters,
                                  headers: headers(forEnvironment: environmentManager.currentEnvironment))
        return request
    }

    internal func addShippingAddressToCartRequest(shipmentId: String,
                                                  shippingAddress: ParameterConvertible,
                                                  useAsBillingAddress: Bool) -> HTTPRequest {
        let path = addShippingAddressToCartPath(shipmentId: shipmentId)
        let parameters = shippingAddress.toParameters()
        return addShippingAddressToCartRequest(forPath: path,
                                               useAsBillingAddress: useAsBillingAddress,
                                               parameters: parameters)
    }

    internal func addShippingAddressToCartRequest(shipmentId: String,
                                                  addressId: String,
                                                  useAsBillingAddress: Bool) -> HTTPRequest {
        let path = addShippingAddressToCartPath(shipmentId: shipmentId)
        let queryItems = ["addressId": addressId]
        return addShippingAddressToCartRequest(forPath: path,
                                               useAsBillingAddress: useAsBillingAddress,
                                               queryItems: queryItems)
    }

    internal func addShippingAddressToCartRequest(forPath path: String,
                                                  useAsBillingAddress: Bool,
                                                  parameters: Parameters) -> HTTPRequest {
        return addShippingAddressToCartRequest(forPath: path, useAsBillingAddress: useAsBillingAddress)
            .with(newParameters: parameters)
    }

    internal func addShippingAddressToCartRequest(forPath path: String,
                                                  useAsBillingAddress: Bool,
                                                  queryItems: QueryItems) -> HTTPRequest {
        return addShippingAddressToCartRequest(forPath: path, useAsBillingAddress: useAsBillingAddress)
            .with(additionalQueryItems: queryItems)
    }

    private func addShippingAddressToCartRequest(forPath path: String, useAsBillingAddress: Bool) -> HTTPRequest {
        let request = HTTPRequest(method: .put,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: path,
                                  queryItems: ["useAsBilling": useAsBillingAddress.toQueryItemValue()],
                                  parameters: nil,
                                  headers: headers(forEnvironment: environmentManager.currentEnvironment))
        return request
    }

    internal func addBillingAddressToCartRequest(billingAddress: ParameterConvertible,
                                                 useAsShippingAddress: Bool) -> HTTPRequest {
        let path = addBillingAddressToCartPath()
        let parameters = billingAddress.toParameters()
        return addBillingAddressToCartRequest(forPath: path,
                                              useAsShippingAddress: useAsShippingAddress,
                                              parameters: parameters)
    }

    internal func addBillingAddressToCartRequest(addressId: String,
                                                 useAsShippingAddress: Bool) -> HTTPRequest {
        let path = addBillingAddressToCartPath()
        let queryItems = ["addressId": addressId]
        return addBillingAddressToCartRequest(forPath: path,
                                              useAsShippingAddress: useAsShippingAddress,
                                              queryItems: queryItems)
    }

    internal func addBillingAddressToCartRequest(forPath path: String,
                                                 useAsShippingAddress: Bool,
                                                 parameters: Parameters) -> HTTPRequest {
        return addBillingAddressToCartRequest(forPath: path, useAsShippingAddress: useAsShippingAddress)
            .with(newParameters: parameters)
    }

    internal func addBillingAddressToCartRequest(forPath path: String,
                                                 useAsShippingAddress: Bool,
                                                 queryItems: QueryItems) -> HTTPRequest {
        return addBillingAddressToCartRequest(forPath: path, useAsShippingAddress: useAsShippingAddress)
            .with(additionalQueryItems: queryItems)
    }

    private func addBillingAddressToCartRequest(forPath path: String, useAsShippingAddress: Bool) -> HTTPRequest {
        let request = HTTPRequest(method: .put,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: path,
                                  queryItems: ["useAsShipping": useAsShippingAddress.toQueryItemValue()],
                                  parameters: nil,
                                  headers: headers(forEnvironment: environmentManager.currentEnvironment))
        return request
    }

    internal func setShippingOptionForCartRequest(shipmentId: String,
                                                  shippingOption: ParameterConvertible) -> HTTPRequest {
        let path = shippingOptionsForCartPath(shipmentId: shipmentId)
        let parameters = shippingOption.toParameters()
        return setShippingOptionForCartRequest(forPath: path, parameters: parameters)
    }

    internal func setShippingOptionForCartRequest(forPath path: String, parameters: Parameters) -> HTTPRequest {
        let request = HTTPRequest(method: .put,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: path,
                                  queryItems: nil,
                                  parameters: parameters,
                                  headers:  headers(forEnvironment: environmentManager.currentEnvironment))
        return request
    }

    internal func shippingOptionsCartRequest(forPath path: String) -> HTTPRequest {
        let request = HTTPRequest(method: .get,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: path,
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: headers(forEnvironment: environmentManager.currentEnvironment))
        return request
    }

    internal func addPaymentMethodToCartRequest(paymentMethod: ParameterConvertible) -> HTTPRequest {
        let path = addPaymentMethodToCartPath()
        let parameters = paymentMethod.toParameters()
        let request = HTTPRequest(method: .post,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: path,
                                  queryItems: nil,
                                  parameters: parameters,
                                  headers: headers(forEnvironment: environmentManager.currentEnvironment))
        return request
    }

    internal func addPaymentMethodToCartRequest(paymentMethodId: String) -> HTTPRequest {
        let path = addPaymentMethodToCartPath()
        let queryItem = ["paymentMethodId": paymentMethodId]
        let request = HTTPRequest(method: .post,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: path,
                                  queryItems: queryItem,
                                  parameters: nil,
                                  headers: headers(forEnvironment: environmentManager.currentEnvironment))
        return request
    }

}
