//
//  ProductSearchCriteriaTests.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 4/30/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class ProductSearchCriteriaTests: XCTestCase {

    func test_SearchCriteria_IsConvertedToQueryItemsCorrectly() {
        //Given
        let searchCriteria = PCFProductSearchCriteria(categoryId: "10018",
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100),
                                                      sortInformation: SortInformation(sort: "tops", order: "asc"))

        //When
        let queryItems = searchCriteria.toQueryItems()

        //Then
        XCTAssertEqual(queryItems["cat"], "10018")
        XCTAssertEqual(queryItems["color"], "bluish,redish")
        XCTAssertEqual(queryItems["sort"], "tops")
        XCTAssertEqual(queryItems["order"], "asc")
        XCTAssertEqual(queryItems["offset"], "0")
        XCTAssertEqual(queryItems["limit"], "100")
    }

    func test_SearchCriteriaEquality_ForKeyword() {
        //Given
        var searchCriteria = PCFProductSearchCriteria(keyword: "dresses",
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100))

        //When
        var testSearchCriteria = PCFProductSearchCriteria(keyword: "dresses",
                                                          filterItems: ["color": "bluish,redish"],
                                                          pageInformation: PageInformation(offset: 0, limit: 100))
        //Then
        XCTAssertEqual(searchCriteria, testSearchCriteria)

        //When
        testSearchCriteria = PCFProductSearchCriteria(keyword: "tops",
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100))
        //Then
        XCTAssertNotEqual(searchCriteria, testSearchCriteria)

        //When
        searchCriteria = PCFProductSearchCriteria(keyword: nil,
                                                  filterItems: ["color": "bluish,redish"],
                                                  pageInformation: PageInformation(offset: 0, limit: 100))

        testSearchCriteria = PCFProductSearchCriteria(keyword: nil,
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100))

        //Then
        XCTAssertEqual(searchCriteria, testSearchCriteria)
    }

    func test_SearchCriteriaEquality_ForCategoryId() {
        //Given
        var searchCriteria = PCFProductSearchCriteria(categoryId: "10018",
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100))

        //When
        var testSearchCriteria = PCFProductSearchCriteria(categoryId: "10018",
                                                          filterItems: ["color": "bluish,redish"],
                                                          pageInformation: PageInformation(offset: 0, limit: 100))
        //Then
        XCTAssertEqual(searchCriteria, testSearchCriteria)

        //When
        testSearchCriteria = PCFProductSearchCriteria(categoryId: "10019",
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100))
        //Then
        XCTAssertNotEqual(searchCriteria, testSearchCriteria)

        //When
        searchCriteria = PCFProductSearchCriteria(categoryId: nil,
                                                  filterItems: ["color": "bluish,redish"],
                                                  pageInformation: PageInformation(offset: 0, limit: 100))

        testSearchCriteria = PCFProductSearchCriteria(categoryId: nil,
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100))

        //Then
        XCTAssertEqual(searchCriteria, testSearchCriteria)
    }

    func test_SearchCriteriaEquality_ForFilterItems() {
        //Given
        var searchCriteria = PCFProductSearchCriteria(keyword: "dresses",
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100))

        //When
        var testSearchCriteria = PCFProductSearchCriteria(keyword: "dresses",
                                                          filterItems: ["color": "bluish,redish"],
                                                          pageInformation: PageInformation(offset: 0, limit: 100))
        //Then
        XCTAssertEqual(searchCriteria, testSearchCriteria)

        //When
        testSearchCriteria = PCFProductSearchCriteria(keyword: "tops",
                                                      filterItems: ["color": "bluish,redish, black"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100))
        //Then
        XCTAssertNotEqual(searchCriteria, testSearchCriteria)

        //When
        searchCriteria = PCFProductSearchCriteria(keyword: "dresses",
                                                  filterItems: nil,
                                                  pageInformation: PageInformation(offset: 0, limit: 100))

        testSearchCriteria = PCFProductSearchCriteria(keyword: "dresses",
                                                      filterItems: nil,
                                                      pageInformation: PageInformation(offset: 0, limit: 100))

        //Then
        XCTAssertEqual(searchCriteria, testSearchCriteria)
    }

    func test_SearchCriteriaEquality_ForPageInformation() {
        //Given
        var searchCriteria = PCFProductSearchCriteria(keyword: "dresses",
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100))

        //When
        var testSearchCriteria = PCFProductSearchCriteria(keyword: "dresses",
                                                          filterItems: ["color": "bluish,redish"],
                                                          pageInformation: PageInformation(offset: 0, limit: 100))
        //Then
        XCTAssertEqual(searchCriteria, testSearchCriteria)

        //When
        testSearchCriteria = PCFProductSearchCriteria(keyword: "tops",
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 10, limit: 100))
        //Then
        XCTAssertNotEqual(searchCriteria, testSearchCriteria)

        //When
        searchCriteria = PCFProductSearchCriteria(keyword: "tops",
                                                  filterItems: ["color": "bluish,redish"],
                                                  pageInformation: nil)

        testSearchCriteria = PCFProductSearchCriteria(keyword: "tops",
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: nil)

        //Then
        XCTAssertEqual(searchCriteria, testSearchCriteria)
    }

    func test_SearchCriteriaEquality_ForSortInformation() {
        //Given
        var searchCriteria = PCFProductSearchCriteria(keyword: "dresses",
                                                      filterItems: ["color": "bluish,redish"],
                                                      sortInformation: SortInformation(sort: "dress", order: "asc"))

        //When
        var testSearchCriteria = PCFProductSearchCriteria(keyword: "dresses",
                                                          filterItems: ["color": "bluish,redish"],
                                                          sortInformation: SortInformation(sort: "dress", order: "asc"))
        //Then
        XCTAssertEqual(searchCriteria, testSearchCriteria)

        //When
        testSearchCriteria = PCFProductSearchCriteria(keyword: "tops",
                                                      filterItems: ["color": "bluish,redish"],
                                                      sortInformation: SortInformation(sort: "dress", order: "desc"))
        //Then
        XCTAssertNotEqual(searchCriteria, testSearchCriteria)

        //When
        searchCriteria = PCFProductSearchCriteria(keyword: "tops",
                                                  filterItems: ["color": "bluish,redish"],
                                                  sortInformation: nil)

        testSearchCriteria = PCFProductSearchCriteria(keyword: "tops",
                                                      filterItems: ["color": "bluish,redish"],
                                                      sortInformation: nil)

        //Then
        XCTAssertEqual(searchCriteria, testSearchCriteria)
    }
}
