//
//  CategoryTree.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  Category tree protocol.
 */
public protocol CategoryTree {

    associatedtype CategoryType: Category

    /// The root categories.
    var rootCategories: [CategoryType] { get set }

    /// The mapped categories object.
    var categoryMap: [String: CategoryType] { get set }

    /**
     The default initializer. `init(categories: [CategoryType])` is preferred to create the category tree.
     */
    init()

    /**
     Creates a category tree with the given flat categories array.

     - parameter categories: The categories to use.
     */
    init(categories: [CategoryType])

    /**
     Returns the sub-categories for the given category.
     If the array is empty it means the given category is a leaf.

     - parameter category: The category to get sub-categories from.

     - returns: The sub-categories available.
     */
    func subCategories(forCategory category: CategoryType) -> [CategoryType]

}

extension CategoryTree {

    /**
     Creates a category tree with the given flat categories array.

     - parameter categories: The categories to use.
     */
    public init(categories: [CategoryType]) {
        self.init()

        var identifierTable = [String: CategoryType]()
        var roots = [CategoryType]()

        for category in categories {
            identifierTable[category.resourceId] = category

            if category.parentCategoryIds.isEmpty {
                roots.append(category)
            }
        }

        rootCategories = roots
        categoryMap = identifierTable
    }

    /**
     Returns the sub-categories for the given category.
     If the array is empty it means the given category is a leaf.

     - parameter category: The category to get sub-categories from.

     - returns: The sub-categories available.
     */
    public func subCategories(forCategory category: CategoryType) -> [CategoryType] {
        var subCategories = [CategoryType]()

        for categoryId in category.subCategoryIds {
            if let category = categoryMap[categoryId] {
                subCategories.append(category)
            }
        }

        return subCategories
    }

}
