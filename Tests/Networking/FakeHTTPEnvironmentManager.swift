//
//  FakeHTTPEnvironmentManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/25/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

@testable import PCFSwift

class FakeHTTPEnvironmentManager: HTTPEnvironmentManager {

    var currentEnvironment: HTTPEnvironment
    let environments: [HTTPEnvironment]

    init(environments: [HTTPEnvironment], initialEnvironment: HTTPEnvironment) {
        self.environments = environments
        self.currentEnvironment = initialEnvironment
    }

    static func fakeEnvironments() -> [HTTPEnvironment] {
        return [
            FakeHTTPEnvironment(name: "QA", baseURL: URL(string: "http://qa.api.io")!),
            FakeHTTPEnvironment(name: "Staging", baseURL: URL(string: "http://staging.api.io")!),
            FakeHTTPEnvironment(name: "Production", baseURL: URL(string: "http://production.api.io")!)
        ]
    }

}
