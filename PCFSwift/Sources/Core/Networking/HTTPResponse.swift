//
//  HTTPResponse.swift
//  PCFSwift
//
//  Created by Harlan Kellaway on 4/18/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

/// Response from successful HTTP request.
public struct HTTPResponse {
    
    // MARK: - Properties

    /// Data.
    public let data: Any
    
    /// Status code.
    public let statusCode: Int?
    
    // MARK: - Initalizers
    
    public init(data: Any, statusCode: Int?) {
        self.data = data
        self.statusCode = statusCode
    }

}
