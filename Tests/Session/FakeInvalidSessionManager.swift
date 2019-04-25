//
//  FakeInvalidSessionManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

@testable import PCFSwift

struct FakeInvalidSessionManager: SessionManager {

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
        let error = PCFError(code: 9000, message: "An unknown error has occurred.")
        completion(error)
    }

}
