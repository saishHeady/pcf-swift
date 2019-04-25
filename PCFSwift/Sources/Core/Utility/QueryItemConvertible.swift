//
//  QueryItemConvertible.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 4/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Defines an object that can be converted into URL query parameters.
public protocol QueryItemConvertible {

    /// Converts the model into query items.
    ///
    /// - Returns: The query items to pass through the request.
    func toQueryItems() -> QueryItems

}
