//
//  PCFAccount.swift
//  PCFSwift
//
//  Created by Thibault Klein on 5/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// PCF account default model.
public struct PCFAccount: Account {

    public let email: String
    public let password: String

    /// Initializes an account.
    ///
    /// - Parameters:
    ///   - email: The email to use.
    ///   - password: The password to use.
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }

}
