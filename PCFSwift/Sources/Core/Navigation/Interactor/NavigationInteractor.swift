//
//  NavigationInteractor.swift
//  PCFSwift
//
//  Created by Daniel Vancura on 3/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Default PCF structure for a navigation interactor.
open class NavigationInteractor<NavigationType: CategoryTree, CategoryType: Category & Swift.Decodable>
where NavigationType.CategoryType == CategoryType {

    public let dataManager: NavigationDataManager<CategoryType>
    public var navigation: NavigationType = NavigationType(categories: [])

    /// Creates a PCFNavigationInteractor with the given data manager.
    ///
    /// - Parameter dataManager: The data manager used for network communication.
    public init(dataManager: NavigationDataManager<CategoryType>) {
        self.dataManager = dataManager
    }

    /// Fetches the navigation hierarchy with the given category ID as parent.
    ///
    /// - Parameters:
    ///   - category: Parent category whose subcategories should be fetched.
    ///   - completion: Completion block for the response of updating the local navigation hierarchy.
    /// - Returns: The response based on the currently saved navigation hierarchy.
    @discardableResult
    open func navigation(forCategory category: NavigationType.CategoryType,
                         completion: @escaping (_ navigation: NavigationType?, _ error: Swift.Error?) -> Void)
        -> NavigationType {
            dataManager.categories(parentCategory: category.name) { (categories, error) in
                let categoryTree = NavigationType(categories: categories)
                completion(categoryTree, error)
            }

            return NavigationType(categories: navigation.subCategories(forCategory: category))
    }

    /// Fetches the entire navigation hierarchy.
    ///
    /// - Parameter completion: Completion block for the remote response.
    /// - Returns: The currently saved navigation hierarchy.
    @discardableResult
    open func navigation(completion: @escaping (_ navigation: NavigationType?, _ error: Swift.Error?) -> Void)
        -> NavigationType {
            dataManager.categories { (categories, error) in
                let categoryTree = NavigationType(categories: categories)
                self.navigation = categoryTree
                completion(categoryTree, error)
            }

            return navigation
    }

}
