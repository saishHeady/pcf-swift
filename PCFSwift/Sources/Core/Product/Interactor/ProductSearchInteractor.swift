//
//  ProductSearchInteractor.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 4/16/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

// swiftlint:disable generic_type_name
/// Default PCF product search interactor.
open class ProductSearchInteractor<ProductSearchType: ProductSearch & Swift.Decodable,
    FilterType: Filter & Swift.Decodable, ProductSearchCriteriaType: ProductSearchCriteria>
where ProductSearchType.FilterType == FilterType {

    /// Data manager used to establish network communication and retrieve data.
    public var dataManager: ProductSearchDataManager<ProductSearchType>

    /// Search Criteria used for retrieving filtered products.
    public var searchCriteria: ProductSearchCriteriaType?

    /// An up-to-date list of products corresponding to all product searches till now.
    public var fetchedProducts: [ProductSearchType.ProductType] = []

    /// The available sort options.
    public var sortOptions: [SortOption] = []

    /// The available filters.
    public var filters: [FilterType] = []

    /// A completion block that takes in the latest product search, an error and whether this is the last page.
    /// `isLastPage` is true if the count of returned products in a search query is less than the specified page limit.
    public typealias ProductSearchCompletion = (_ productSearch: ProductSearchType?,
        _ error: Swift.Error?,
        _ isLastPage: Bool) -> Void

    /// Creates a PCFProductSearchInteractor with the given data manager.
    ///
    /// - Parameter dataManager: The data manager used for network communication.
    public init(dataManager: ProductSearchDataManager<ProductSearchType>) {
        self.dataManager = dataManager
    }

    /// Retrieves products based on a criteria.
    ///
    /// - Parameters:
    ///   - searchCriteria: An object that can be converted to URL query to be used for filtering products.
    ///   - completion: The completion block.
    open func fetchProducts(with searchCriteria: ProductSearchCriteriaType,
                            completion: @escaping ProductSearchCompletion) {
        self.searchCriteria = searchCriteria
        dataManager.filteredProducts(searchCriteria: searchCriteria) { [weak self] (productSearch, error) in
            guard var currentProductSearch = productSearch else {
                completion(productSearch, error, false)
                return
            }

            self?.sortOptions = currentProductSearch.sortOptions
            self?.filters = currentProductSearch.filters
            self?.fetchedProducts = currentProductSearch.products
            currentProductSearch.products = self?.fetchedProducts ?? []
            let isLastPage = (self?.fetchedProducts.count ?? 0) >= currentProductSearch.totalResults

            completion(currentProductSearch, error, isLastPage)
        }
    }

    /// Retrieves the next page of products based on the current page information in the search criteria.
    /// An undefined search criteria should be treated as an error.
    ///
    /// - Parameter completion: The completion block.
    open func loadNextPage(completion: @escaping ProductSearchCompletion) throws {
        guard let searchCriteria = self.searchCriteria else {
            throw PCFError(code: -2, message: "Search criteria must be defined.")
        }

        let nextOffset = (searchCriteria.pageInformation?.offset ?? 0) + (searchCriteria.pageInformation?.limit ?? 0)
        let nextPageInformation = PageInformation(offset: nextOffset,
                                                  limit: searchCriteria.pageInformation?.limit ?? 0)

        guard let nextPageSearchCriteria = PCFProductSearchCriteria(keyword: searchCriteria.keyword,
                                                                    categoryId: searchCriteria.categoryId,
                                                                    filterItems: searchCriteria.filterItems,
                                                                    pageInformation: nextPageInformation,
                                                                    sortInformation: searchCriteria.sortInformation)
            as? ProductSearchCriteriaType else {
                return
        }

        self.searchCriteria = nextPageSearchCriteria
        dataManager.filteredProducts(searchCriteria: searchCriteria) { [weak self] (productSearch, error) in
            guard var currentProductSearch = productSearch else {
                completion(productSearch, error, false)
                return
            }

            self?.sortOptions = currentProductSearch.sortOptions
            self?.filters = currentProductSearch.filters
            self?.fetchedProducts += currentProductSearch.products

            currentProductSearch.products = self?.fetchedProducts ?? []
            let isLastPage = (self?.fetchedProducts.count ?? 0) >= currentProductSearch.totalResults

            completion(currentProductSearch, error, isLastPage)
        }
    }

    /// Returns the selected sort option.
    ///
    /// - Returns: The selected sort option.
    open func selectedSortOption() -> SortOption? {
        return sortOptions.filter({ $0.isSelected }).first
    }

    /// Returns the selected filter entries.
    ///
    /// - Returns: The selected filter entries.
    open func selectedFilterEntries() -> [FilterType.FilterEntryType] {
        var selectedFilterEntries: [FilterType.FilterEntryType] = []

        for categoryFilter in filters {
            let filteredEntries = categoryFilter.entries.filter({ $0.isSelected })
            selectedFilterEntries.append(contentsOf: filteredEntries)
        }

        return selectedFilterEntries
    }

    private func searchCriteriaDidUpdate(_ newSearchCriteria: ProductSearchCriteriaType) -> Bool {
        if let currentSearchCriteria = self.searchCriteria, currentSearchCriteria != newSearchCriteria {
            return true
        }
        return false
    }

}
