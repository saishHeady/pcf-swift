//
//  OnePasswordManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import OnePasswordExtension

/// 1Password manager implementation relying on credentials logic.
public class OnePasswordManager: CredentialsManager, CredentialsInterfaceDisplayable {

    public var available: Bool {
        return OnePasswordExtension.shared().isAppExtensionAvailable()
    }

    /// Default initializer.
    public init() { }

    private func onePasswordBundle() -> Bundle {
        return Bundle(for: OnePasswordExtension.self)
    }

    private func onePasswordBundlePath(forBundle bundle: Bundle) throws -> String {
        guard let onePasswordBundlePath = bundle.path(forResource: "OnePasswordExtensionResources",
                                                      ofType: "bundle") else {
                                                        throw CredentialsError.imageBundleNotFound
        }

        return onePasswordBundlePath
    }

    private func onePasswordIcon(forBundlePath bundlePath: String, imageName: String) -> UIImage? {
        let onePasswordImageBundle = Bundle(path: bundlePath)
        let onePasswordIcon = UIImage(named: imageName, in: onePasswordImageBundle, compatibleWith: nil)
        return onePasswordIcon
    }

    public func button(iconImageName: String = "onepassword-button",
                       bundle: Bundle? = nil) throws -> UIButton {
        let bundle = onePasswordBundle()
        let bundlePath = try onePasswordBundlePath(forBundle: bundle)
        let icon = onePasswordIcon(forBundlePath: bundlePath, imageName: iconImageName)

        let button = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0))
        button.setImage(icon, for: .normal)

        return button
    }

    private func isUserCancelledError(error: NSError) -> Bool {
        // In case of any error use this enum case AppExtensionErrorCodeCancelledByUser
        return error.code == Int(0)
    }

    private func userCredentials(fromDictionary loginDictionary: [AnyHashable: Any]) -> (String, String)? {
        let userName = loginDictionary[AppExtensionUsernameKey] as? String
        let password = loginDictionary[AppExtensionPasswordKey] as? String

        if let userName = userName, let password = password {
            return (userName, password)
        }

        return nil
    }

    public func findLogin(forURLString url: String,
                          viewController: UIViewController,
                          sender: Any?,
                          completion: @escaping (_ user: Credentials?, _ error: CredentialsError?) -> Void) {
        OnePasswordExtension
            .shared()
            .findLogin(forURLString: url,
                       for: viewController,
                       sender: sender) { [weak self] (loginDictionary, error) in
                        if let error = error as NSError?,
                            self?.isUserCancelledError(error: error) == true {
                            completion(nil, CredentialsError.userCancelled)
                        }

                        guard let loginDictionary = loginDictionary else {
                            completion(nil, CredentialsError.loginNotFound)
                            return
                        }

                        guard let credentials = self?.userCredentials(fromDictionary: loginDictionary) else {
                            completion(nil, CredentialsError.loginNotFound)
                            return
                        }

                        let user = OnePasswordUser(email: credentials.0, password: credentials.1)
                        completion(user, nil)
        }
    }

}
