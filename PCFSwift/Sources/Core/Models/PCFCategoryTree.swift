//
//  PCFCategoryTree.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

/**
 *  PCFCategoryTree model.
 */
public struct PCFCategoryTree: CategoryTree {

    public typealias CategoryType = PCFCategory

    /// The root categories.
    public var rootCategories: [CategoryType] = []

    /// The mapped categories object.
    public var categoryMap: [String: CategoryType] = [:]

    /**
     The default initializer. `init(categories: [CategoryType])` is preferred to create the category tree.
     */
    public init() {}

}
