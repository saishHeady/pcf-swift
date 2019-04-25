//
//  CategoryMapTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class CategoryMapTests: XCTestCase {

    var categories = [PCFCategory]()
    var categoryTree: PCFCategoryTree!

    override func setUp() {
        super.setUp()

        do {
            let categoriesJSONArrayData = try TestServer.getJSONData("SingleCategoryMap")
            categories = try JSONDecoder().decode([PCFCategory].self, from: categoriesJSONArrayData)
            categoryTree = PCFCategoryTree(categories: categories)
        } catch {
            XCTFail("Can't open Single Category Map JSON")
        }
    }

    override func tearDown() {
        categories.removeAll()
        categoryTree = nil

        super.tearDown()
    }

    func testCategoryTree() {
        XCTAssertNotNil(categoryTree)

        // Given
        let rootCategories = categoryTree.rootCategories
        // When
        let expectedCount = 1
        let expectedSubcount = 1
        // Then
        XCTAssertEqual(rootCategories.count, expectedCount)
        XCTAssertEqual(categoryTree.subCategories(forCategory: rootCategories.first!).count, expectedSubcount)
    }

    func testCategoryLeaves() {
        // Given
        let rootCategories = categoryTree.rootCategories
        let firstSubcategory = categoryTree.subCategories(forCategory: rootCategories.first!).first!
        let leaves = categoryTree.subCategories(forCategory: firstSubcategory)
        let firstLeaf = leaves[0]
        let secondLeaf = leaves[1]
        // When
        let expectedCount = 2
        // Then
        XCTAssertEqual(leaves.count, expectedCount)

        XCTAssertEqual(firstLeaf.resourceId, "3")
        XCTAssertEqual(firstLeaf.name, "Category 3")
        XCTAssertEqual(firstLeaf.images.imageURL("small"), URL(string: "http://img.url3.jpg"))
        XCTAssertEqual(firstLeaf.parentCategoryIds, ["1"])
        XCTAssertEqual(firstLeaf.tags, ["highlight", "main", "tops"])
        XCTAssertEqual(firstLeaf.subCategoryIds, [])

        XCTAssertEqual(secondLeaf.resourceId, "4")
        XCTAssertEqual(secondLeaf.name, "Category 4")
        XCTAssertEqual(secondLeaf.images.imageURL("small"), URL(string: "http://img.url4.jpg"))
        XCTAssertEqual(secondLeaf.parentCategoryIds, ["1"])
        XCTAssertEqual(secondLeaf.tags, ["highlight", "main", "bottoms"])
        XCTAssertEqual(secondLeaf.subCategoryIds, [])
    }

    func testSubCategories() {
        // Given
        let rootCategories = categoryTree.rootCategories
        let firstSubcategory = categoryTree.subCategories(forCategory: rootCategories.first!).first!
        // Then
        XCTAssertEqual(firstSubcategory.resourceId, "1")
        XCTAssertEqual(firstSubcategory.name, "Category 1")
        XCTAssertEqual(firstSubcategory.images.imageURL("small"), URL(string: "http://img.url.jpg"))
        XCTAssertEqual(firstSubcategory.parentCategoryIds, ["2"])
        XCTAssertEqual(firstSubcategory.tags, ["highlight", "main"])
        XCTAssertEqual(firstSubcategory.subCategoryIds, ["3", "4"])
    }

}
