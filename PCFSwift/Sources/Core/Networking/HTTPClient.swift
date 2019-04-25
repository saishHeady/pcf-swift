//
//  HTTPClient.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/19/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

public typealias JSON = [String: Any]

/// HTTP client.
public protocol HTTPClient {

    /// Performs a HTTP request.
    ///
    /// - Parameters:
    ///   - request: The request to use.
    ///   - completion: The completion block.
    func perform(request: HTTPRequest,
                 completion: @escaping (_ response: HTTPResponse?, _ error: Swift.Error?) -> Void)

}
