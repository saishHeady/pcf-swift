//
//  KillSwitchManagerTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 5/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import Bellerophon
@testable import PCFSwift

class KillSwitchManagerTests: XCTestCase {

    var killSwitchManager: KillSwitchManager!
    let errorHandler: (NSError) -> Void = { (_) in }

    override func setUp() {
        super.setUp()

        let client = FakeHTTPClient(jsonName: "KillSwitch")
        let request = HTTPRequest(method: .get,
                                  baseURL: URL(string: "http://google.com")!,
                                  path: "",
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: nil)

        killSwitchManager = KillSwitchManager(httpClient: client,
                                              httpRequest: request,
                                              window: UIWindow(),
                                              killSwitchView: UIView(),
                                              errorHandler: errorHandler)
    }

    override func tearDown() {
        killSwitchManager = nil

        super.tearDown()
    }

    func testKillSwitchManagerCreation() {
        XCTAssertNotNil(killSwitchManager.httpClient)
        XCTAssertNotNil(killSwitchManager.httpRequest)
        XCTAssertNotNil(killSwitchManager.killSwitch)
    }

    func testKillSwitch_whenAppStatusGetsBack() {
        let exp = expectation(description: "Kill Switch status result")
        killSwitchManager.checkAppStatus()

        XCTAssertNotNil(killSwitchManager.killSwitch)
        killSwitchManager.bellerophonStatus(killSwitchManager.killSwitch!) { (status, error) in
            XCTAssertNotNil(status)
            XCTAssertNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testKillSwitch_whenJSONIsInvalid() {
        let client = FakeHTTPClient(jsonName: "SingleProduct")
        let request = HTTPRequest(method: .get,
                                  baseURL: URL(string: "http://google.com")!,
                                  path: "",
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: nil)
        let view = UIView()
        let killSwitchManager = KillSwitchManager(httpClient: client,
                                                  httpRequest: request,
                                                  window: UIWindow(),
                                                  killSwitchView: view,
                                                  errorHandler: errorHandler)

        let exp = expectation(description: "Kill Switch status result")
        killSwitchManager.checkAppStatus()

        XCTAssertNotNil(killSwitchManager.killSwitch)
        killSwitchManager.bellerophonStatus(killSwitchManager.killSwitch!) { (status, error) in
            XCTAssertNil(status)
            XCTAssertNotNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testKillSwitch_whenRequestReturnsAnError() {
        let client = FakeHTTPClient(jsonName: "nonexistent JSON")
        let request = HTTPRequest(method: .get,
                                  baseURL: URL(string: "http://google.com")!,
                                  path: "",
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: nil)
        let view = UIView()
        let killSwitchManager = KillSwitchManager(httpClient: client,
                                                  httpRequest: request,
                                                  window: UIWindow(),
                                                  killSwitchView: view,
                                                  errorHandler: errorHandler)

        let exp = expectation(description: "Kill Switch status result")
        killSwitchManager.checkAppStatus()

        XCTAssertNotNil(killSwitchManager.killSwitch)
        killSwitchManager.bellerophonStatus(killSwitchManager.killSwitch!) { (status, error) in
            XCTAssertNil(status)
            XCTAssertNotNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testKillSwitch_whenForceUpgradeIsActive() {
        let client = FakeHTTPClient(jsonName: "ForceUpgrade")
        let request = HTTPRequest(method: .get,
                                  baseURL: URL(string: "http://google.com")!,
                                  path: "",
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: nil)
        let view = UIView()
        let killSwitchManager = KillSwitchManager(httpClient: client,
                                                  httpRequest: request,
                                                  window: UIWindow(),
                                                  killSwitchView: view,
                                                  errorHandler: errorHandler)

        let exp = expectation(description: "Kill Switch status result")
        killSwitchManager.checkAppStatus()

        XCTAssertNotNil(killSwitchManager.killSwitch)
        killSwitchManager.bellerophonStatus(killSwitchManager.killSwitch!) { (status, error) in
            XCTAssertNotNil(status)
            XCTAssertNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

}
