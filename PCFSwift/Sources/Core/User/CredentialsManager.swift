//
//  CredentialsManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Credentials manager protocol.
public protocol CredentialsManager {

    /// Indicates if the credentials manager is available to use.
    var available: Bool { get }

    /// Finds the user's login information based on the given URL domain. The view controller passed as a parameter
    /// is used to display the front end UI for getting the login.
    ///
    /// - Parameters:
    ///   - url: The credentials domain.
    ///   - viewController: The view controller for UI display logic.
    ///   - sender: The action sender.
    ///   - completion: The completion block containing either the user credentials or an error.
    func findLogin(forURLString url: String,
                   viewController: UIViewController,
                   sender: Any?,
                   completion: @escaping (_ user: Credentials?, _ error: CredentialsError?) -> Void)

}
