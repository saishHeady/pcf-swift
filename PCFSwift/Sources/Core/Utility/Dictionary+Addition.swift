//
//  Dictionary+Addition.swift
//  Pods
//
//  Created by Sagar Natekar on 3/14/17.
//
//

public extension Dictionary {

    /// Adds elements of self to the passed-in dictionary and returns the result
    ///
    /// - Parameters:
    /// - dict: Dictionary to add
    /// - Returns: Result of adding dict's (key, value) pairs to self
    public func combineWith<Key: Hashable, Value>(_ dict: [Key: Value]) -> [Key: Value] {
        var result = dict

        for (key, value) in self {
            if let key = key as? Key {
                result[key] = value as? Value
            }
        }

        return result
    }

}
