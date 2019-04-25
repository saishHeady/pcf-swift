//
//  CredentialsInterfaceDisplayable.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Credentials interface displayable protocol.
public protocol CredentialsInterfaceDisplayable {

    /// Returns a button to access user credentials interface.
    ///
    /// - Parameters:
    ///   - iconImageName: The icon image name to use.
    ///   - bundle: The bundle to use for the image.
    /// - Returns: The button to use.
    /// - Throws: An error in case the button couldn't be created.
    func button(iconImageName: String, bundle: Bundle?) throws -> UIButton

}
