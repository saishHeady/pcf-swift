//
//  FakeTouchIDAvailableManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/25/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

@testable import PCFSwift

struct FakeTouchIDAvailableManager: TouchIDManager {

    func isAvailable() throws -> Bool {
        return true
    }

    var isActive: Bool {
        return true
    }

}
