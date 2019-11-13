//
//  KillSwitchModel.swift
//  PCFSwift
//
//  Created by Thibault Klein on 5/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Bellerophon

/// Kill switch model to observe the app status.
class KillSwitchModel: BellerophonObservable, Swift.Decodable {

    /// Indicates if the app is inactive.
    let isAPIInactive: Bool

    /// Indicates if the app should be forced to update.
    let shouldForceUpdate: Bool

    /// The interval to check the app status once the app is inactive.
    let interval: TimeInterval

    /// The user message to display when the app is inactive.
    let userMessageString: String

    // MARK: - BellerophonObservable Functions

    func apiInactive() -> Bool {
        return isAPIInactive
    }

    func forceUpdate() -> Bool {
        return shouldForceUpdate
    }

    func retryInterval() -> TimeInterval {
        return interval
    }

    func userMessage() -> String {
        return userMessageString
    }
    
    func setUserMessage(_ message: String) { }

    // MARK: - Swift.Decodable

    private enum KillSwitchCodingKeys: String, CodingKey {
        case isAPIInactive = "apiInactive"
        case shouldForceUpdate = "forceUpdate"
        case interval = "retryInterval"
        case userMessageString = "userMessage"
    }

    public required init(from decoder: Swift.Decoder) throws {
        let killSwitchContainer = try decoder.container(keyedBy: KillSwitchCodingKeys.self)

        isAPIInactive = try killSwitchContainer.decode(Bool.self, forKey: .isAPIInactive)
        shouldForceUpdate = try killSwitchContainer.decode(Bool.self, forKey: .shouldForceUpdate)
        interval = try killSwitchContainer.decode(Double.self, forKey: .interval)
        userMessageString = try killSwitchContainer.decode(String.self, forKey: .userMessageString)

    }

}
