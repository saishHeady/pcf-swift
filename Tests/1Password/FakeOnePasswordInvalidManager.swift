//
//  FakeOnePasswordInvalidManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

@testable import PCFSwift

class FakeOnePasswordInvalidManager: OnePasswordManager {

    override func findLogin(forURLString url: String,
                            viewController: UIViewController,
                            sender: Any?,
                            completion: @escaping (_ user: Credentials?, _ error: CredentialsError?) -> Void) {
        let error = CredentialsError.loginNotFound
        completion(nil, error)
    }

}
