//
//  StoreInteractor.swift
//  PCFSwift
//
//  Created by Thibault Klein on 6/29/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Store interactor.
open class StoreInteractor<StoreType: Store & Swift.Decodable> {

    /// Data manager used to establish network communication and retrieve data.
    public let dataManager: StoreDataManager<StoreType>

    /// Creates a StoreInteractor with the given data manager.
    ///
    /// - Parameter dataManager: The data manager used for network communication.
    public init(dataManager: StoreDataManager<StoreType>) {
        self.dataManager = dataManager
    }

    /// Gets all the stores.
    ///
    /// - Parameter completion: The completion block.
    open func stores(completion: @escaping (_ stores: [StoreType], _ error: Swift.Error?) -> Void) {
        dataManager.stores(completion: completion)
    }

    /// Gets the store details information for the given store id.
    ///
    /// - Parameters:
    ///   - storeId: The store id to use.
    ///   - completion: The completion block.
    open func store(forStoreId storeId: String,
                    completion: @escaping (_ stores: StoreType?, _ error: Swift.Error?) -> Void) {
        dataManager.store(forStoreId: storeId, completion: completion)
    }

}
