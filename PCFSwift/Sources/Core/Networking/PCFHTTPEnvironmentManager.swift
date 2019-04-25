//
//  PCFHTTPEnvironmentManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 3/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Default PCF HTTP environment manager.
public class PCFHTTPEnvironmentManager: HTTPEnvironmentManager {

    public var currentEnvironment: HTTPEnvironment
    public var environments: [HTTPEnvironment]

    /// Initializes the default PCF HTTP environment manager.
    ///
    /// - Parameters:
    ///   - currentEnvironment: The current environment to use.
    ///   - environments: All the accessible environments.
    public init(currentEnvironment: HTTPEnvironment, environments: [HTTPEnvironment]) {
        self.currentEnvironment = currentEnvironment
        self.environments = environments
    }

}
