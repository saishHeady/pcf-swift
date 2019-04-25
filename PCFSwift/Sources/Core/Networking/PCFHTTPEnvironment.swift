//
//  PCFHTTPEnvironment.swift
//  PCFSwift
//
//  Created by Thibault Klein on 3/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Default PCF HTTP environment object.
public struct PCFHTTPEnvironment: HTTPEnvironment, Codable {

    public var name: String
    public var baseURL: URL

    /// Initializes a PCF HTTP environment.
    ///
    /// - Parameters:
    ///   - name: The environment name.
    ///   - baseURL: The environment base URL.
    public init(name: String, baseURL: URL) {
        self.name = name
        self.baseURL = baseURL
    }

}
