//
//  Bool+QueryItem.swift
//  PCFSwift
//
//  Created by Harlan Kellaway on 9/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

extension Bool {

    /// Transforms boolean value to type usable as QueryItem value.
    ///
    /// - Returns: QueryItem value.
    func toQueryItemValue() -> String {
        switch self {
        case true:
            return "true"
        case false:
            return "false"
        }
    }

}
