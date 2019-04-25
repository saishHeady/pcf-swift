//
//  TestError.swift
//  PCFSwift
//
//  Created by Daniel Vancura on 4/29/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

/**
 Error type for the case of errors within the test environment

 - JSONFileNotFound:          Error for the case that a file was not found.
 - JSONDeserializationFailed: Error for the case that the JSON serializer failed
 to parse a data object to JSON.
 - JSONFormatInvalid:         Error for the case that the JSON format was invalid.
 */
enum TestError: Swift.Error {

    /// Error for the case that a file was not found.
    case jsonFileNotFound(filePath: String)

    /// Error for the case that the JSON serializer failed to parse a data object to JSON.
    case jsonDeserializationFailed(jsonSerializationError: Error, data: Data)

    /// Error for the case that the JSON format was invalid.
    case jsonFormatInvalid(invalidObject: AnyObject)

}
