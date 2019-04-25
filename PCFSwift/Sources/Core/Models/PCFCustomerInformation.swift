//
//  PCFCustomerInformation.swift
//  PCFSwift
//
//  Created by Thibault Klein on 11/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// PCFCustomerInformation model.
public struct PCFCustomerInformation: CustomerInformation, Swift.Decodable {

    public let customerNumber: String?
    public let email: String?

}
