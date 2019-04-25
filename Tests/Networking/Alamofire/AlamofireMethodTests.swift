//
//  AlamofireMethodTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/28/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import Alamofire
@testable import PCFSwift

class AlamofireMethodTests: XCTestCase {

    func testAlamofireGETMethod() {
        let pcfMethod = PCFSwift.HTTPMethod.get
        let expectedMethod = pcfMethod.alamofireMethod
        XCTAssertEqual(expectedMethod, Alamofire.HTTPMethod.get)
    }

    func testAlamofirePOSTMethod() {
        let pcfMethod = PCFSwift.HTTPMethod.post
        let expectedMethod = pcfMethod.alamofireMethod
        XCTAssertEqual(expectedMethod, Alamofire.HTTPMethod.post)
    }

    func testAlamofireDELETEMethod() {
        let pcfMethod = PCFSwift.HTTPMethod.delete
        let expectedMethod = pcfMethod.alamofireMethod
        XCTAssertEqual(expectedMethod, Alamofire.HTTPMethod.delete)
    }

    func testAlamofirePUTMethod() {
        let pcfMethod = PCFSwift.HTTPMethod.put
        let expectedMethod = pcfMethod.alamofireMethod
        XCTAssertEqual(expectedMethod, Alamofire.HTTPMethod.put)
    }

}
