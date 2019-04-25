//
//  PCFProductSearch.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  PCFProductSearch model.
 */
public struct PCFProductSearch: ProductSearch, Swift.Decodable {

    public typealias FilterType = PCFFilter
    public typealias ProductType = PCFProduct
    public typealias SortOptionType = PCFSortOption

    /// A list of ShortProduct given one or many categories and a list of filters.
    public var products: [ProductType]

    /// Total number of results for the search query.
    public let totalResults: Int

    /// An array of Filter to be used with the search endpoint.
    public let filters: [FilterType]

    /// An array of SortOption to be used with the search endpoint.
    public let sortOptions: [SortOptionType]

}

// MARK: - Swift.Decodable

public extension PCFProductSearch {

    private enum ProductSearchCodingKeys: String, CodingKey {
        case products
        case totalResults
        case filters
        case sortOptions
    }

    public init(from decoder: Swift.Decoder) throws {
        let productSearchContainer = try decoder.container(keyedBy: ProductSearchCodingKeys.self)

        products = try productSearchContainer.decodeIfPresent([ProductType].self, forKey: .products) ?? []
        totalResults = try productSearchContainer.decode(Int.self, forKey: .totalResults)
        filters = try productSearchContainer.decodeIfPresent([FilterType].self, forKey: .filters) ?? []
        sortOptions = try productSearchContainer.decodeIfPresent([SortOptionType].self, forKey: .sortOptions) ?? []

    }

}
