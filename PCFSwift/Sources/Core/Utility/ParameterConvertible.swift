//
//  ParameterConvertible.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/4/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Defines an object that can be converted into URL parameters.
public protocol ParameterConvertible {

    /// Converts the model into parameters.
    ///
    /// - Returns: The parameters to use.
    func toParameters() -> Parameters

}
