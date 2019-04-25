//
//  HTTPEnvironmentManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/25/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// The HTTP environment manager.
public protocol HTTPEnvironmentManager: class {

    /// The current HTTP environment.
    var currentEnvironment: HTTPEnvironment { get set }

    /// All the available HTTP environments.
    var environments: [HTTPEnvironment] { get }

}
