//
//  FakeSessionManager.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 3/14/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

@testable import PCFSwift

struct FakeSessionManager: SessionManager {

    public let httpClient: HTTPClient
    public let environmentManager: HTTPEnvironmentManager
    public let persistenceClient: Persistable?

    public var sessionHeaders: Headers {
        return [:]
    }

    func isSessionExpired() -> Bool {
        return false
    }

    func retrieveSessionIdentifier(completion: @escaping (_ error: Swift.Error?) -> Void) {
        let sessionIdentifier = "1234567"
        persistenceClient?.set(sessionIdentifier, forKey: "sessionId")
        completion(nil)
    }

}
