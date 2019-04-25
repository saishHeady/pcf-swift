//
//  Credentials.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// User credentials protocol.
public protocol Credentials {

    /// Email credentials.
    var email: String { get }

    /// Password credentials.
    var password: String { get }

}
