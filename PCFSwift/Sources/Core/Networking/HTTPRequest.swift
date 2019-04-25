//
//  HTTPRequest.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/19/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

public typealias Parameters = [String: Any]
public typealias Headers = [String: String]
public typealias QueryItems = [String: String]

/// HTTP request.
public struct HTTPRequest {

    /// HTTP method.
    public let method: HTTPMethod

    /// HTTP request base URL.
    public let baseURL: URL

    /// HTTP request path.
    public let path: String

    /// HTTP Query items.
    public let queryItems: QueryItems?

    /// HTTP request parameters.
    public let parameters: Parameters?

    /// HTTP request headers.
    public let headers: Headers?

    /// HTTP endpoint. Combines the base URL and the path to be used for a HTTP call.
    public var endpoint: URL {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            return baseURL.appendingPathComponent(path)
        }

        components.path.append(path)
        let query = queryItems?.map { URLQueryItem(name: $0.key, value: $0.value) }
        components.queryItems = query
        return components.url ?? baseURL.appendingPathComponent(path)
    }

    /// Initializes a HTTP request.
    ///
    /// - Parameters:
    ///   - method: The HTTP method to use.
    ///   - baseURL: The HTTP base URL to use.
    ///   - path: The HTTP path to use.
    ///   - query: The HTTP query items to use.
    ///   - parameters: The HTTP parameters to use.
    ///   - headers: The HTTP headers to use.
    public init(method: HTTPMethod,
                baseURL: URL,
                path: String,
                queryItems: QueryItems?,
                parameters: Parameters?,
                headers: Headers?) {
        self.method = method
        self.baseURL = baseURL
        self.path = path
        self.queryItems = queryItems
        self.parameters = parameters
        self.headers = headers
    }

}

// MARK: Factory functions

extension HTTPRequest {

    /// Creates new instance with provided query items in addition to exisiting.
    ///
    /// - Parameter newQueryItems: New query items to use.
    /// - Returns: New instance.
    public func with(additionalQueryItems: QueryItems) -> HTTPRequest {
        let newQueryItems: QueryItems = (queryItems == nil) ? [:] : queryItems!.combineWith(additionalQueryItems)
        return with(newQueryItems: newQueryItems)
    }

    /// Creates new instance with updated parameters.
    ///
    /// - Parameter newParameters: New parameters to use.
    /// - Returns: New instance.
    public func with(newParameters: Parameters) -> HTTPRequest {
        return HTTPRequest(method: method,
                           baseURL: baseURL,
                           path: path,
                           queryItems: queryItems,
                           parameters: newParameters,
                           headers: headers)
    }

    /// Creates new instance with updated query items.
    ///
    /// - Parameter newQueryItems: New query items to use.
    /// - Returns: New instance.
    public func with(newQueryItems: QueryItems) -> HTTPRequest {
        return HTTPRequest(method: method,
                           baseURL: baseURL,
                           path: path,
                           queryItems: newQueryItems,
                           parameters: parameters,
                           headers: headers)
    }

}
