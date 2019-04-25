//
//  OrderDataManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Default order data manager for the standard PCF cart.
open class OrderDataManager<OrderType: Order & Swift.Decodable, OrderDetailType: OrderDetail & Swift.Decodable>: DataManager {

    public let environmentManager: HTTPEnvironmentManager
    public let httpClient: HTTPClient
    public let sessionManager: SessionManager
    public var decoder: JSONDecoder

    /// Initializes an order data manager.
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

    /// All orders request path.
    open var ordersRequestPath: String {
        return "/orders"
    }

    /// Order request path based on the given id.
    ///
    /// - Parameter orderId: The order id to use.
    /// - Returns: The order request path to use.
    open func orderRequestPath(forOrderId orderId: String) -> String {
        return "\(ordersRequestPath)/\(orderId)"
    }

    /// Gets all the orders from the order history.
    ///
    /// - Parameter completion: The completion block.
    open func orders(completion: @escaping (_ orders: [OrderType], _ error: Swift.Error?) -> Void) {
        let request = orderRequest(forPath: ordersRequestPath)
        perform(request: request, completion: completion)
    }

    /// Get the order based on the given id.
    ///
    /// - Parameters:
    ///   - orderId: The order id to use.
    ///   - completion: The completion block.
    open func orderDetail(forOrderId orderId: String,
                          completion: @escaping (_ order: OrderDetailType?, _ error: Swift.Error?) -> Void) {
        let path = orderRequestPath(forOrderId: orderId)
        let request = orderRequest(forPath: path)
        perform(request: request, completion: completion)
    }

    func orderRequest(forPath path: String) -> HTTPRequest {
        let request = HTTPRequest(method: .get,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: path,
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: headers(forEnvironment: environmentManager.currentEnvironment))
        return request
    }

}
