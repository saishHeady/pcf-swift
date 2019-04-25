//
//  OrderInteractor.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Default PCF order interactor.
open class OrderInteractor<OrderType: Order & Swift.Decodable, OrderDetailType: OrderDetail & Swift.Decodable> {

    /// Data manager used to establish network communication and retrieve data.
    public let dataManager: OrderDataManager<OrderType, OrderDetailType>

    /// Creates a OrderInteractor with the given data manager.
    ///
    /// - Parameter dataManager: The data manager used for network communication.
    public init(dataManager: OrderDataManager<OrderType, OrderDetailType>) {
        self.dataManager = dataManager
    }

    /// Gets all the orders from the order history.
    ///
    /// - Parameter completion: The completion block.
    open func orders(completion: @escaping (_ orders: [OrderType], _ error: Swift.Error?) -> Void) {
        dataManager.orders(completion: completion)
    }

    /// Get the order based on the given id.
    ///
    /// - Parameters:
    ///   - orderId: The order id to use.
    ///   - completion: The completion block.
    open func orderDetail(forOrderId orderId: String,
                          completion: @escaping (_ order: OrderDetailType?, _ error: Swift.Error?) -> Void) {
        dataManager.orderDetail(forOrderId: orderId, completion: completion)
    }

}
