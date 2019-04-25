//
//  PageInformation.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 4/14/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Combines paging information to be used in product search criteria
public struct PageInformation: Equatable {

    /// The index of the starting product of the resulting products. If `limit` is specified this should be specified.
    public let offset: Int

    /// The number of products that should be returned. If `offset` is specified this should be specified.
    public let limit: Int

    /// Creates a PageInformation from the offset and limit.
    ///
    /// - Parameters:
    ///   - offset: Offset information.
    ///   - limit: Limit information.
    public init(offset: Int, limit: Int) {
        self.offset = offset
        self.limit = limit
    }

}

public func == (lhs: PageInformation, rhs: PageInformation) -> Bool {
    return lhs.offset == rhs.offset && lhs.limit == rhs.limit
}
