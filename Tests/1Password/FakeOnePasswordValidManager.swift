//
//  FakeOnePasswordValidManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

@testable import PCFSwift

class FakeOnePasswordValidManager: OnePasswordManager {

    override func findLogin(forURLString url: String,
                            viewController: UIViewController,
                            sender: Any?,
                            completion: @escaping (_ user: Credentials?, _ error: CredentialsError?) -> Void) {
        let user = OnePasswordUser(email: "Bruce Wayne", password: "Gotham")
        completion(user, nil)
    }

}
