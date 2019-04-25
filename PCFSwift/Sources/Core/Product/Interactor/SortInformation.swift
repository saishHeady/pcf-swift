//
//  SortInformation.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 4/14/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Combines sorting information to be used in product search criteria
public struct SortInformation: Equatable {

    /// The sort type. If `order` is specified this should be specified.
    public let sort: String

    /// The order to sort by. If `sort` is specified this should be specified.
    public let order: String

    /// Creates a SortInformation from the sort type and order for the sort.
    ///
    /// - Parameters:
    ///   - sort: Sort information
    ///   - order: Order information
    public init(sort: String, order: String) {
        self.sort = sort
        self.order = order
    }

}

public func == (lhs: SortInformation, rhs: SortInformation) -> Bool {
    return lhs.sort == rhs.sort && lhs.order == rhs.order
}
