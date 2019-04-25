//
//  CustomerInformation.swift
//  PCFSwift
//
//  Created by Thibault Klein on 11/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// The customer information model.
public protocol CustomerInformation {

    /// The customer's number.
    var customerNumber: String? { get }

    /// The customer's email.
    var email: String? { get }

}
