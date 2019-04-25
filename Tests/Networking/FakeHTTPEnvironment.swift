//
//  FakeHTTPEnvironment.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/25/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

@testable import PCFSwift

struct FakeHTTPEnvironment: HTTPEnvironment {
    let name: String
    let baseURL: URL
}
