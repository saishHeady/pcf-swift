//
//  AlamofireClientTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class AlamofireClientTests: XCTestCase {

    func testAlamofireClientCreation() {
        let client = AlamofireHTTPClient()
        XCTAssertNotNil(client)
    }

}
