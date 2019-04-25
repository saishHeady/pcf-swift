//
//  StoreDataManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 6/29/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Store data manager.
open class StoreDataManager<StoreType: Store & Swift.Decodable>: DataManager {

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

    /// All stores request path.
    open var storesRequestPath: String {
        return "/stores"
    }

    /// Store request path based on the given id.
    ///
    /// - Parameter storeId: The store id to use.
    /// - Returns: The store request path to use.
    open func storeRequestPath(forStoreId storeId: String) -> String {
        return "\(storesRequestPath)/\(storeId)"
    }

    /// Gets all the stores.
    ///
    /// - Parameter completion: The completion block.
    open func stores(completion: @escaping (_ stores: [StoreType], _ error: Swift.Error?) -> Void) {
        let request = storeRequest(forPath: storesRequestPath)
        perform(request: request, completion: completion)
    }

    /// Gets the store details information for the given store id.
    ///
    /// - Parameters:
    ///   - storeId: The store id to use.
    ///   - completion: The completion block.
    open func store(forStoreId storeId: String,
                    completion: @escaping (_ stores: StoreType?, _ error: Swift.Error?) -> Void) {
        let path = storeRequestPath(forStoreId: storeId)
        let request = storeRequest(forPath: path)
        perform(request: request, completion: completion)
    }

    func storeRequest(forPath path: String) -> HTTPRequest {
        let request = HTTPRequest(method: .get,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: path,
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: headers(forEnvironment: environmentManager.currentEnvironment))
        return request
    }

}
