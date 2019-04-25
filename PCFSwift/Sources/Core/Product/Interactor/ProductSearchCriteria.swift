//
//  ProductSearchCriteria.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 4/9/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Definition of a product search criteria object.
public protocol ProductSearchCriteria: QueryItemConvertible, Equatable {

    /// The keyword used to specify search query.
    var keyword: String? { get }

    /// Category id used to specify search query.
    var categoryId: String? { get }

    /// Filter items to be sent through the search query, set using available filters returned by a previous search.
    var filterItems: QueryItems? { get }

    /// Paging information for the search query.
    var pageInformation: PageInformation? { get }

    /// Sorting information for the search query.
    var sortInformation: SortInformation? { get }

}

public func ==<T: ProductSearchCriteria>(lhs: T, rhs: T) -> Bool {
    var keywordsEqual = false
    var categoryIdEqual = false
    var filterItemsEqual = false
    var pageInfoEqual = false
    var sortInfoEqual = false

    if let lhsKeyword = lhs.keyword, let rhsKeyword = rhs.keyword {
        keywordsEqual = lhsKeyword == rhsKeyword
    } else if lhs.keyword == nil && rhs.keyword == nil {
        keywordsEqual = true
    }

    if let lhsCategoryId = lhs.categoryId, let rhsCategoryId = rhs.categoryId {
        categoryIdEqual = lhsCategoryId == rhsCategoryId
    } else if lhs.categoryId == nil && rhs.categoryId == nil {
        categoryIdEqual = true
    }

    if let lhsFilterItems = lhs.filterItems, let rhsFilterItems = rhs.filterItems {
        filterItemsEqual = lhsFilterItems == rhsFilterItems
    } else if lhs.filterItems == nil && rhs.filterItems == nil {
        filterItemsEqual = true
    }

    if let lhsPageInfo = lhs.pageInformation, let rhsPageInfo = rhs.pageInformation {
        pageInfoEqual = lhsPageInfo == rhsPageInfo
    } else if lhs.pageInformation == nil && rhs.pageInformation == nil {
        pageInfoEqual = true
    }

    if let lhsSortInfo = lhs.sortInformation, let rhsSortInfo = rhs.sortInformation {
        sortInfoEqual = lhsSortInfo == rhsSortInfo
    } else if lhs.sortInformation == nil && rhs.sortInformation == nil {
        sortInfoEqual = true
    }

    return keywordsEqual && categoryIdEqual && filterItemsEqual && pageInfoEqual && sortInfoEqual
}
