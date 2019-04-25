//
//  KeyPersistable.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 3/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Saves and retrieves (key, value) pairs to/from disk
public protocol Persistable {

    /// Returns the object associated with the occurrence of the specified key.
    ///
    /// - Parameter key: The key used to identify the object
    /// - Returns: The object associated with the specified key, or nil if the key was not found.
    func object(forKey key: String) -> Any?

    /// Sets the value of the specified key to the specified object
    ///
    /// - Parameters:
    ///   - object: The object to persist
    ///   - defaultName: The key with which to associate with the object.
    func set(_ object: Any?, forKey defaultName: String)

    /// Removes the object associated with the specified key.
    ///
    /// - Parameters:
    ///   - key: The key with which the object is associated.
    func removeObject(forKey key: String)

}
