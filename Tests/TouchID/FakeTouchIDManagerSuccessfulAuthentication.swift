//
//  FakeTouchIDManagerSuccessfulAuthentication.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/25/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

@testable import PCFSwift

struct FakeTouchIDManagerSuccessfulAuth: TouchIDManager {

    func authenticate(forReason reason: String,
                      completion: @escaping (_ success: Bool, _ error: Swift.Error?) -> Void) {
        completion(true, nil)
    }
}
