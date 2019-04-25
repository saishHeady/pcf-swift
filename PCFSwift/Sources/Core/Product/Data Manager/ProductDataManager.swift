//
//  ProductDataManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 3/21/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Default data manager for the standard PCF product.
open class ProductDataManager<ProductType: Product & Swift.Decodable, SkuType: Sku & Swift.Decodable>: DataManager {

    public let environmentManager: HTTPEnvironmentManager
    public let httpClient: HTTPClient
    public let sessionManager: SessionManager
    public var decoder: JSONDecoder

    public init(environmentManager: HTTPEnvironmentManager,
                sessionManager: SessionManager,
                httpClient: HTTPClient,
                decoder: JSONDecoder = JSONDecoder()) {
        self.environmentManager = environmentManager
        self.sessionManager = sessionManager
        self.httpClient = httpClient
        self.decoder = decoder
    }

    /// Gets the full product for the given product id.
    ///
    /// - Parameters:
    ///   - productId: The product id to use.
    ///   - completion: The completion block that is called upon receiving the response
    /// with either a product object or and error.
    open func product(forProductId productId: String,
                      completion: @escaping (_ product: ProductType?, _ error: Swift.Error?) -> Void) {
        let path = productRequestPath(forProductId: productId)
        let request = getRequest(forPath: path)
        perform(request: request, completion: completion)
    }

    /// Gets the SKU matching the given SKU id and product id.
    ///
    /// - Parameters:
    ///   - skuId: The SKU id to use.
    ///   - productId: The product id to use.
    ///   - completion: The completion block.
    open func sku(forSkuId skuId: String,
                  productId: String,
                  completion: @escaping (_ sku: SkuType?, _ error: Swift.Error?) -> Void) {
        let path = skuRequestPath(forSkuId: skuId, productId: productId)
        let request = getRequest(forPath: path)
        perform(request: request, completion: completion)
    }

    /// Returns the product request path based on the given product id.
    ///
    /// - Parameter productId: The product id to use.
    /// - Returns: The product request path to use.
    open func productRequestPath(forProductId productId: String) -> String {
        return "/products/\(productId)"
    }

    /// Returns the SKU request path based on the SKU id and product id.
    ///
    /// - Parameters:
    ///   - skuId: The SKU id to use.
    ///   - productId: The product id to use.
    /// - Returns: The SKU request path to use.
    open func skuRequestPath(forSkuId skuId: String, productId: String) -> String {
        return "/products/\(productId)/skus/\(skuId)"
    }

    internal func getRequest(forPath path: String) -> HTTPRequest {
        let request = HTTPRequest(method: .get,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: path,
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: headers(forEnvironment: environmentManager.currentEnvironment))
        return request
    }

}
