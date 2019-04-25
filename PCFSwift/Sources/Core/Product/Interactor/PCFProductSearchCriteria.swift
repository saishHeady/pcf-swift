//
//  PCFProductSearchCriteria.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/7/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Data transfer object to search for products for product search HTTP request.
public struct PCFProductSearchCriteria: ProductSearchCriteria {

    public let keyword: String?
    public let categoryId: String?
    public let filterItems: QueryItems?
    public let pageInformation: PageInformation?
    public let sortInformation: SortInformation?

    /// Default initializer for a product search data transfer object.
    ///
    /// - Parameters:
    ///   - keyword: The keyword to use.
    ///   - categoryId: Category id to use.
    ///   - filterItems: Filter items to use.
    ///   - pageInformation: Page information (offset,limit) to use.
    ///   - sortInformation: Sort information (sort type, order) to use for sorting resulting products.
    public init(keyword: String? = nil,
                categoryId: String? = nil,
                filterItems: QueryItems? = nil,
                pageInformation: PageInformation? = nil,
                sortInformation: SortInformation? = nil) {
        self.keyword = keyword
        self.categoryId = categoryId
        self.filterItems = filterItems
        self.pageInformation = pageInformation
        self.sortInformation = sortInformation
    }

    public func toQueryItems() -> QueryItems {
        var queryItems = QueryItems()

        queryItems["keyword"] = keyword
        queryItems["cat"] = categoryId
        queryItems["sort"] = sortInformation?.sort
        queryItems["order"] = sortInformation?.order

        if let pageInformation = pageInformation {
            queryItems["offset"] = "\(pageInformation.offset)"
            queryItems["limit"] = "\(pageInformation.limit)"
        }

        if let filterItems = filterItems {
            queryItems = queryItems.combineWith(filterItems)
        }

        return queryItems
    }

}
