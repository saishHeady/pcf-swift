//
//  TestServer.swift
//  PCFSwift
//
//  Created by Daniel Vancura on 4/29/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
@testable import PCFSwift

/// A "test server" that provides JSON data from `.json` files which are added to the test bundle.
class TestServer {

    /**
     Retrieves the JSON data contained in a file named `jsonFileName`.json or nil,
     if there was an error when loading this JSON data. Prints a descriptive error message
     when returning nil.

     - parameter jsonFileName: The name of the file which contains the json data
     without the `.json` file ending.

     - returns: The JSON contained in the respective file or nil, if the loading failed.
     */
    static func testGetJSON(_ jsonFileName: String) -> [String: AnyObject]? {
        do {
            return try TestServer.getJSON(jsonFileName)
        } catch {
            switch error {
            case TestError.jsonDeserializationFailed(let error, let data):
                print("Deserialization failed with error: \(error), with data: \(data)")
            case TestError.jsonFormatInvalid(let object):
                print("Deserialization format is wrong: \(object)")
            case TestError.jsonFileNotFound(let fileName):
                print("File not found: \(fileName)")
            default:
                print(error)
            }

            return nil
        }
    }

    /**
     Retrieves the JSON data contained in a file named `jsonFileName`.json.

     - throws: A `TestError` if anything failed when loading JSON from the file.

     - parameter jsonFileName: The name of the file which contains the json data
     without the `.json` file ending.

     - returns: The JSON contained in the respective file.
     */
    static func getJSON(_ jsonFileName: String) throws -> [String: AnyObject] {
        guard let data = loadJsonFile(jsonFileName) else {
            throw TestError.jsonFileNotFound(filePath: "\(jsonFileName).json")
        }

        return try deserializeJSON(data)
    }

    /**
     Retrieves the JSON data contained in a file named `jsonFileName`.json.

     - throws: A `TestError` if anything failed when loading JSON from the file.

     - parameter jsonFileName: The name of the file which contains the json data
     without the `.json` file ending.

     - returns: The JSON contained in the respective file.
     */
    static func getJSONArray(_ jsonFileName: String) throws -> [[String: AnyObject]] {
        guard let data = loadJsonFile(jsonFileName) else {
            throw TestError.jsonFileNotFound(filePath: "\(jsonFileName).json")
        }

        return try deserializeJSONArray(data)
    }

    /// Retrieves the JSON data contained in a file named `jsonFileName`.json
    ///
    /// - Parameter jsonFileName: The name of the file which contains the json data
    ///             without the `.json` file ending.
    /// - Returns: The file's data.
    /// - Throws: A `TestError` if anything failed when loading JSON from the file.
    static func getJSONData(_ jsonFileName: String) throws -> Data {
        guard let data = loadJsonFile(jsonFileName) else {
            throw TestError.jsonFileNotFound(filePath: "\(jsonFileName).json")
        }

        return data
    }

    /**
     Loads the raw data of a JSON file.

     - parameter name: The file name without `.json` extension

     - returns: The file's data.
     */
    fileprivate static func loadJsonFile(_ name: String) -> Data? {
        let bundle = Bundle(for: TestServer.self)
        guard let jsonFileURL = bundle.path(forResource: name, ofType: "json") else {
            return nil
        }
        do {
            let content = try String(contentsOfFile: jsonFileURL)
            return content.data(using: String.Encoding.utf8)
        } catch {
            return nil
        }
    }

    /**
     Deserializes the JSON data to a dictionary.

     - parameter data: The JSON data to be parsed.

     - throws: TestError object.

     - returns: The JSON structure or nil, if the parsing failed.
     */
    fileprivate static func deserializeJSON(_ data: Data) throws -> [String: AnyObject] {
        do {
            let object =
                try JSONSerialization
                    .jsonObject(with: data,
                                options: JSONSerialization.ReadingOptions.mutableContainers)

            guard let result = object as? [String: AnyObject] else {
                throw TestError.jsonFormatInvalid(invalidObject: object as AnyObject)
            }

            return result
        } catch {
            throw TestError.jsonDeserializationFailed(jsonSerializationError: error, data: data)
        }
    }

    /**
     Deserializes the JSON data to an array.

     - parameter data: The JSON data to be parsed.

     - throws: TestError object.

     - returns: The JSON array structure or nil, if the parsing failed.
     */
    fileprivate static func deserializeJSONArray(_ data: Data) throws -> [[String: AnyObject]] {
        do {
            let object =
                try JSONSerialization
                    .jsonObject(with: data,
                                options: JSONSerialization.ReadingOptions.mutableContainers)

            guard let result = object as? [[String: AnyObject]] else {
                throw TestError.jsonFormatInvalid(invalidObject: object as AnyObject)
            }

            return result
        } catch {
            throw TestError.jsonDeserializationFailed(jsonSerializationError: error, data: data)
        }
    }
}
