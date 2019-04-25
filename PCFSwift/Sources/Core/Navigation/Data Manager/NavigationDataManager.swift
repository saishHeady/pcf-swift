//
//  NavigationDataManager.swift
//  PCFSwift
//
//  Created by Daniel Vancura on 3/7/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Default data manager for the standard PCF navigation structure.
open class NavigationDataManager<CategoryType: Category & Swift.Decodable>: DataManager {

    public let environmentManager: HTTPEnvironmentManager
    public let httpClient: HTTPClient
    public let sessionManager: SessionManager
    public var decoder: JSONDecoder

    /// The API path to use.
    open var path: String {
        return "/categories"
    }

    public init(environmentManager: HTTPEnvironmentManager,
                sessionManager: SessionManager,
                httpClient: HTTPClient,
                decoder: JSONDecoder = JSONDecoder()) {
        self.environmentManager = environmentManager
        self.sessionManager = sessionManager
        self.httpClient = httpClient
        self.decoder = decoder
    }

    /// Gets all categories available
    ///
    /// - Parameter completion: Completion block that is called upon receiving the response with either
    ///                         a list of sub-categories or an empty list and error.
    open func categories(completion: @escaping ([CategoryType], Swift.Error?) -> Void) {
        let request = getRequest()
        perform(request: request, completion: completion)
    }

    /// Gets all categories that are sub-categories of `parentCategory`
    ///
    /// - Parameters:
    ///   - parentCategory: The ID of the parent category whose sub-categories are to be fetched.
    ///   - completion: Completion block that is called upon receiving the response with either
    ///                 a list of sub-categories or an empty list and error.
    open func categories(parentCategory: String, completion: @escaping ([CategoryType], Swift.Error?) -> Void) {
        let request = getRequest(forCategory: parentCategory)
        perform(request: request, completion: completion)
    }

    internal func getRequest(forCategory category: String? = nil) -> HTTPRequest {
        let queryItems = category.map { return ["parentCategoryId": $0] }
        let request = HTTPRequest(method: .get,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: path,
                                  queryItems: queryItems,
                                  parameters: nil,
                                  headers: headers(forEnvironment: environmentManager.currentEnvironment))

        return request
    }

}
