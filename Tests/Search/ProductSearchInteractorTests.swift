//
//  ProductSearchInteractorTests.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 4/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class ProductSearchInteractorTests: BaseTestDataManager {

    private var dataManager: ProductSearchDataManager<PCFProductSearch>!

    override func setUp() {
        super.setUp()

        dataManager = ProductSearchDataManager(environmentManager: envManager,
                                               sessionManager: sessionManager,
                                               httpClient: FakeHTTPClient(jsonName: "SingleProductSearch"),
                                               decoder: JSONDecoder())
    }

    override func tearDown() {
        dataManager = nil
        super.tearDown()
    }

    func testFetchingProductsWithSearchCriteria_IsSuccessful() {
        //Given
        let interactor =
            ProductSearchInteractor<PCFProductSearch, PCFFilter, PCFProductSearchCriteria>(dataManager: dataManager)
        let exp = expectation(description: "Retrieving filtered products")
        let searchCriteria = PCFProductSearchCriteria(categoryId: "10018",
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100))

        //When
        interactor.fetchProducts(with: searchCriteria) { (productSearch, error, _) in
            //Then
            guard let productSearch = productSearch else {
                XCTFail("Expected valid response, got nil product search response")
                return
            }

            XCTAssertEqual(productSearch.totalResults, 1)
            XCTAssertTrue(productSearch.products.count == 1)
            XCTAssertTrue(productSearch.filters.count == 1)
            XCTAssertTrue(productSearch.filters.first!.entries.count == 2)
            XCTAssertTrue(productSearch.sortOptions.count == 2)
            XCTAssertNil(error)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testFetchingProductsForTheFirstTime_SetsFetchedProductsArrayCorrectly() {
        //Given
        let interactor =
            ProductSearchInteractor<PCFProductSearch, PCFFilter, PCFProductSearchCriteria>(dataManager: dataManager)
        let exp = expectation(description: "Retrieving filtered products")
        let searchCriteria = PCFProductSearchCriteria(categoryId: "10018",
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100))

        //When
        interactor.fetchProducts(with: searchCriteria) { (_, _, _) in
            //Then
            XCTAssertTrue(interactor.fetchedProducts.count == 1)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchingProductsAtDifferentPages_ConcatenatesProductSetsCorrectly() {
        //Given
        let interactor =
            ProductSearchInteractor<PCFProductSearch, PCFFilter, PCFProductSearchCriteria>(dataManager: dataManager)
        let exp = expectation(description: "Retrieving filtered products")
        let searchCriteria = PCFProductSearchCriteria(categoryId: "10018",
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100))

        //When
        interactor.fetchProducts(with: searchCriteria) { (_, _, _) in
            //Given
            let page2HTTPClient = FakeHTTPClient(jsonName: "SingleProductSearchPage2")
            let page2DataManager = ProductSearchDataManager<PCFProductSearch>(environmentManager: self.envManager,
                                                                              sessionManager: self.sessionManager,
                                                                              httpClient: page2HTTPClient,
                                                                              decoder: JSONDecoder())
            interactor.dataManager = page2DataManager

            //When
            try? interactor.loadNextPage { (_, _, _) in
                //Then
                XCTAssertTrue(interactor.fetchedProducts.count == 2)
                XCTAssertTrue(interactor.fetchedProducts[0].resourceId == "1234")
                XCTAssertTrue(interactor.fetchedProducts[1].resourceId == "5678")
                exp.fulfill()
            }

        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchingProductsOnLastPage_NotifiesLastPageIsReturned() {
        //Given
        let interactor =
            ProductSearchInteractor<PCFProductSearch, PCFFilter, PCFProductSearchCriteria>(dataManager: dataManager)
        let exp = expectation(description: "Retrieving filtered products")
        let searchCriteria = PCFProductSearchCriteria(categoryId: "10018",
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 0, limit: 5))

        //When
        interactor.fetchProducts(with: searchCriteria) { (_, _, isLastPage) in
            //Then
            XCTAssertTrue(isLastPage, "Expected last page to be returned")
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchedProductsAreReset_WhenSearchCriteriaChanges() {
        //Given
        let interactor =
            ProductSearchInteractor<PCFProductSearch, PCFFilter, PCFProductSearchCriteria>(dataManager: dataManager)
        let exp = expectation(description: "Product array reset")
        var searchCriteria = PCFProductSearchCriteria(categoryId: "10018",
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100))
        interactor.fetchProducts(with: searchCriteria) { (_, _, _) in
            //When
            searchCriteria = PCFProductSearchCriteria(categoryId: "10018",
                                                      filterItems: ["color": "bluish,redish,black"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100))

            interactor.fetchProducts(with: searchCriteria) { (_, _, _) in
                //Then
                XCTAssertTrue(interactor.fetchedProducts.count == 1)
                exp.fulfill()
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testLoadingNextPage_WithoutSearchCriteria_ThrowsCorrectError() {
        //Given
        let interactor =
            ProductSearchInteractor<PCFProductSearch, PCFFilter, PCFProductSearchCriteria>(dataManager: dataManager)

        //When
        do {
            try interactor.loadNextPage { _, _, _ in }
        } catch let error {
            //Then
            XCTAssert(error is PCFError)
            //swiftlint:disable force_cast
            XCTAssertTrue((error as! PCFError).code == -2, "Expected method to throw error with correct code")
            XCTAssertTrue((error as! PCFError).message == "Search criteria must be defined.",
                          "Expected method to throw error with correct message")
        }

    }

    func testLoadingNextPage_WithSearchCriteria_UpdatesPageInformationCorrectly() {
        //Given
        let interactor =
            ProductSearchInteractor<PCFProductSearch, PCFFilter, PCFProductSearchCriteria>(dataManager: dataManager)
        let searchCriteria = PCFProductSearchCriteria(categoryId: "10018",
                                                      filterItems: ["color": "bluish,redish"],
                                                      pageInformation: PageInformation(offset: 0, limit: 100))
        interactor.searchCriteria = searchCriteria

        //When
        try? interactor.loadNextPage { _, _, _ in }

        //Then
        let expOffset = (searchCriteria.pageInformation?.offset ?? 0) + (searchCriteria.pageInformation?.limit ?? 0)
        let expLimit = searchCriteria.pageInformation?.limit ?? 0
        XCTAssertTrue(interactor.searchCriteria?.pageInformation?.offset == expOffset)
        XCTAssertTrue(interactor.searchCriteria?.pageInformation?.limit == expLimit)
    }

    func testSelectedSortOptions() {
        // Given
        let interactor =
            ProductSearchInteractor<PCFProductSearch, PCFFilter, PCFProductSearchCriteria>(dataManager: dataManager)
        let searchCriteria = PCFProductSearchCriteria(categoryId: "10018")
        let exp = expectation(description: "Retrieving filtered products")

        //When
        interactor.fetchProducts(with: searchCriteria) { (productSearch, _, _) in
            //Then
            guard productSearch != nil else {
                XCTFail("Expected valid response, got nil product search response")
                return
            }

            let selectedSortOption = interactor.selectedSortOption()
            XCTAssertNotNil(selectedSortOption)
            XCTAssertEqual(selectedSortOption?.label, "Bestsellers")
            XCTAssertEqual(selectedSortOption?.sort, "popularity")
            XCTAssertEqual(selectedSortOption?.order, "desc")

            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testSelectedFilters() {
        // Given
        let interactor =
            ProductSearchInteractor<PCFProductSearch, PCFFilter, PCFProductSearchCriteria>(dataManager: dataManager)
        let searchCriteria = PCFProductSearchCriteria(categoryId: "10018")
        let exp = expectation(description: "Retrieving filtered products")

        //When
        interactor.fetchProducts(with: searchCriteria) { (productSearch, _, _) in
            //Then
            guard productSearch != nil else {
                XCTFail("Expected valid response, got nil product search response")
                return
            }

            let selectedFilters = interactor.selectedFilterEntries()
            XCTAssertTrue(selectedFilters.count > 0)
            let firstSelectedFilterEntry = selectedFilters[0]
            XCTAssertEqual(firstSelectedFilterEntry.value, "bluish")
            XCTAssertEqual(firstSelectedFilterEntry.label, "Blue-ish")
            XCTAssertEqual(firstSelectedFilterEntry.quantity, 1)
            XCTAssertEqual(firstSelectedFilterEntry.hex, "#1111AA")

            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

}
