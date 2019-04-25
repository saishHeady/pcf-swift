//
//  FakeUserDefaults.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 3/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

@testable import PCFSwift

class FakeUserDefaults: Persistable {

    fileprivate(set) var valueWasPersisted = false

    func object(forKey key: String) -> Any? {
        return nil
    }

    func set(_ object: Any?, forKey defaultName: String) {
        valueWasPersisted = true
    }

    func removeObject(forKey key: String) {

    }

}
