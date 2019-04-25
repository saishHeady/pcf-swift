//
//  TouchIDManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/25/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import LocalAuthentication

private let touchIDPreferenceKey = "touchIDPreferenceKey"

/// Touch ID manager.
public protocol TouchIDManager {

    /// Indicates if TouchID is active.
    var isActive: Bool { get }

    /// Indicates if Touch ID is available for the device.
    ///
    /// - Returns: `true` if Touch ID is available. `false` if not.
    /// - Throws: The authentication error.
    func isAvailable() throws -> Bool

    /// Activates TouchID.
    func activate()

    /// Deactivate TouchID.
    func deactivate()

    /// Authenticates the user using TouchID.
    ///
    /// - Parameters:
    ///   - reason: The reason why you try to authenticate. The string will be displayed in the TouchID alert.
    ///   - completion: The completion block.
    func authenticate(forReason reason: String,
                      completion: @escaping (_ success: Bool, _ error: Swift.Error?) -> Void)

}

public extension TouchIDManager {

    var isActive: Bool {
        return UserDefaults.standard.bool(forKey: touchIDPreferenceKey)
    }

    func isAvailable() throws -> Bool {
        var authError: NSError? = nil
        if LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            return true
        } else if let error = authError {
            throw error
        }

        return false
    }

    func activate() {
        setTouchIDActivation(true)
    }

    func deactivate() {
        setTouchIDActivation(false)
    }

    func authenticate(forReason reason: String,
                      completion: @escaping (_ success: Bool, _ error: Swift.Error?) -> Void) {
        do {
            if try isAvailable() && isActive {
                LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                           localizedReason: reason) { (success, error) in
                                            completion(success, error)
                }
            } else {
                completion(false, nil)
            }
        } catch let error {
            completion(false, error)
        }
    }

    private func setTouchIDActivation(_ activation: Bool) {
        UserDefaults.standard.set(activation, forKey: touchIDPreferenceKey)
        UserDefaults.standard.synchronize()
    }

}
