//
//  BaseTestDataManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/4/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class BaseTestDataManager: XCTestCase {

    let environments = FakeHTTPEnvironmentManager.fakeEnvironments()
    var envManager: HTTPEnvironmentManager!
    var sessionManager: SessionManager!

    override func setUp() {
        super.setUp()

        envManager = FakeHTTPEnvironmentManager(environments: environments,
                                                initialEnvironment: environments.first!)
        sessionManager = FakeSessionManager(httpClient: FakeHTTPClient(),
                                            environmentManager: envManager,
                                            persistenceClient: FakeUserDefaults())
    }

    override func tearDown() {
        envManager = nil
        sessionManager = nil

        super.tearDown()
    }

}
