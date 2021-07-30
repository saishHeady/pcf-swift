//
//  PCFError.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/21/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  PCFError model.
 */
public struct PCFError: Error, Swift.Decodable {

    /// An error identifier used for API error.
    public let code: Int

    /// A human (end user friendly) readable/comprehensible description of the error.
    public let message: String

    /// Initializes a PCF error.
    ///
    /// - Parameters:
    ///   - code: The error code to use.
    ///   - message: The error message to use.
    public init(code: Int, message: String) {
        self.code = code
        self.message = message
    }

}

// MARK: - Default errors
public extension PCFError {

    /// Error for mal-formatted JSON, such as receiving arrays when expecting dictionaries as response.
    static var invalidJSON: PCFError {
        return PCFError(code: -1, message: "Invalid JSON response")
    }

}

// MARK: - Equatable
extension PCFError: Equatable {}

public func == (_ lhs: PCFError, _ rhs: PCFError) -> Bool {
    return lhs.code == rhs.code
}
