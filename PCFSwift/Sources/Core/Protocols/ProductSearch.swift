//
//  ProductSearch.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  The product search protocol.
 */
public protocol ProductSearch {

    associatedtype FilterType: Filter
    associatedtype ProductType: Product
    associatedtype SortOptionType: SortOption

    /// A list of ShortProduct given one or many categories and a list of filters.
    var products: [ProductType] { get set }

    /// Total number of results for the search query.
    var totalResults: Int { get }

    /// An array of Filter to be used with the search endpoint.
    var filters: [FilterType] { get }

    /// An array of SortOption to be used with the search endpoint.
    var sortOptions: [SortOptionType] { get }

}
