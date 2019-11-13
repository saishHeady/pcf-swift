//
//  Error.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/21/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

private enum SessionErrorCode: Int {
    case inactiveSession = 1002
    case invalidSession = 12000
}

/**
 *  Error protocol.
 */
public protocol Error: LocalizedError {

    /// An error identifier used for API error.
    var code: Int { get }

    /// A human (end user friendly) readable/comprehensible description of the error.
    var message: String { get }

}

public extension Error {

    /// Indicates if the error is a session error. Can be useful to know if a new session has to be generated.
    ///
    /// - Returns: `true` if the error is related to the session. `false` if not.
    func isSessionError() -> Bool {
        let isSessionInactive = code == SessionErrorCode.inactiveSession.rawValue
        let isSessionInvalid = code == SessionErrorCode.invalidSession.rawValue

        return isSessionInvalid || isSessionInactive
    }

    var errorDescription: String? {
        return message
    }

}
