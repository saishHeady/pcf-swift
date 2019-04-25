//
//  ProductSearchDataManager.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 4/9/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Default product search data manager for the standard PCF product search.
open class ProductSearchDataManager<ProductSearchType: ProductSearch & Swift.Decodable>: DataManager {

    public let environmentManager: HTTPEnvironmentManager
    public let httpClient: HTTPClient
    public let sessionManager: SessionManager
    public var decoder: JSONDecoder

    /// Product search data manager request path.
    open var path: String {
        return "/products/search"
    }

    /// Creates a PCFProductSearchDataManager with the given parameters
    ///
    /// - Parameters:
    ///   - environmentManager: The environment manager
    ///   - sessionManager: The session manager
    ///   - httpClient: The HTTP client
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

    // swiftlint:disable line_length

    /// Searches for products based on a criteria.
    ///
    /// - Parameters:
    ///   - searchCriteria: An object that can be converted to URL query to be used for filtering products.
    ///   - completion: The completion block.
    open func filteredProducts(searchCriteria: QueryItemConvertible,
                               completion: @escaping (_ productSearch: ProductSearchType?, _ error: Swift.Error?) -> Void) {
        let request = getProductSearchRequest(forPath: path, queryItems: searchCriteria.toQueryItems())
        perform(request: request, completion: completion)
    }

    internal func getProductSearchRequest(forPath path: String, queryItems: QueryItems) -> HTTPRequest {
        let request = HTTPRequest(method: .get,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: path,
                                  queryItems: queryItems,
                                  parameters: nil,
                                  headers: headers(forEnvironment: environmentManager.currentEnvironment))
        return request
    }

}
