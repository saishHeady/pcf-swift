//
//  CredentialsError.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Credentials errors.
///
/// - imageBundleNotFound: Indicates when the image couldn't be found for a credentials button icon.
/// - loginNotFound: Indicates when login information couldn't be found.
/// - userCancelled: Indicates when user cancelled an action.
public enum CredentialsError: Swift.Error, Equatable {

    case imageBundleNotFound
    case loginNotFound
    case userCancelled

}

public func == (lhs: CredentialsError, rhs: CredentialsError) -> Bool {
    switch (lhs, rhs) {
    case (.imageBundleNotFound, .imageBundleNotFound):
        return true
    case (.loginNotFound, .loginNotFound):
        return true
    case (.userCancelled, .userCancelled):
        return true
    default:
        return false
    }
}
