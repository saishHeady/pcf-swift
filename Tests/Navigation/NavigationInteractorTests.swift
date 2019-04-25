//
//  NavigationInteractorTests.swift
//  PCFSwift
//
//  Created by Daniel Vancura on 3/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class NavigationInteractorTests: BaseTestDataManager {

    private var dataManager: NavigationDataManager<PCFCategory>!

    override func tearDown() {
        dataManager = nil

        super.tearDown()
    }

    func testLoadNavigation() {
        dataManager = NavigationDataManager(environmentManager: envManager,
                                            sessionManager: sessionManager,
                                            httpClient: FakeHTTPClient(jsonName: "SingleCategoryMap"),
                                            decoder: JSONDecoder())
        let interactor = NavigationInteractor<PCFCategoryTree, PCFCategory>(dataManager: dataManager)

        let exp = expectation(description: "testLoadNavigation")

        let navigation = interactor.navigation { (categoryTree, error) in
            XCTAssertNotNil(categoryTree)
            XCTAssertNil(error)
            XCTAssertEqual(categoryTree?.rootCategories.map { $0.resourceId } ?? [], ["2"])
            exp.fulfill()
        }

        XCTAssertTrue(navigation.rootCategories.isEmpty)
        XCTAssertTrue(navigation.categoryMap.isEmpty)

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadSubNavigation() {
        dataManager = NavigationDataManager(environmentManager: envManager,
                                            sessionManager: sessionManager,
                                            httpClient: FakeHTTPClient(jsonName: "SubCategoryMap"),
                                            decoder: JSONDecoder())
        let interactor = NavigationInteractor<PCFCategoryTree, PCFCategory>(dataManager: dataManager)

        let exp = expectation(description: "testLoadSubNavigation")

        var category: PCFCategory!

        do {
            let categoryJSONData = try TestServer.getJSONData("SingleCategory")
            category = try JSONDecoder().decode(PCFCategory.self, from: categoryJSONData)
        } catch {
            XCTFail("Can't open SingleCategory JSON")
        }

        interactor.navigation(forCategory: category) { (navigation, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(navigation)

            // Test if root category is not in there anymore
            XCTAssertTrue(navigation?.categoryMap.values.map { $0.resourceId }.filter { $0 == "2"}.isEmpty ?? false)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testNavigationInteractorError() {
        dataManager = NavigationDataManager(environmentManager: envManager,
                                            sessionManager: sessionManager,
                                            httpClient: FakeHTTPClient(),
                                            decoder: JSONDecoder())
        let interactor = NavigationInteractor<PCFCategoryTree, PCFCategory>(dataManager: dataManager)
        let exp = expectation(description: "testError")

        interactor.navigation { (navigation, error) in
            XCTAssertTrue(navigation?.categoryMap.isEmpty ?? false)
            XCTAssertTrue(navigation?.rootCategories.isEmpty ?? false)
            XCTAssertNotNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

}
