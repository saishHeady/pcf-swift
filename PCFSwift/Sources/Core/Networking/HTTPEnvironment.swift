//
//  HTTPEnvironment.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/19/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// HTTP environment.
public protocol HTTPEnvironment {

    /// Environment name (e.g. "QA", "Production")
    var name: String { get }

    /// Environment base URL.
    var baseURL: URL { get }

}

extension HTTPEnvironment {

    /// Default headers for the current HTTP environment
    var defaultHTTPHeaders: Headers {
        return [
            "Content-Type": "application/json; charset=utf-8"
        ]
    }

}
