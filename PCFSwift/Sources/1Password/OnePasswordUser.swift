//
//  OnePasswordUser.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// 1Password user definition.
public class OnePasswordUser: Credentials {

    public let email: String
    public let password: String

    /// Default initializer for a 1Password user.
    ///
    /// - Parameters:
    ///   - email: The email from 1Password.
    ///   - password: The password from 1Password.
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }

}
