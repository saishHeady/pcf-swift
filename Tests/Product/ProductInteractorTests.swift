//
//  ProductInteractorTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 3/22/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

// swiftlint:disable type_body_length
// swiftlint:disable file_length
class ProductInteractorTests: BaseTestDataManager {

    private var dataManager: ProductDataManager<PCFProduct, PCFSku>!
    private var product: PCFProduct!
    private var productOutOfStock: PCFProduct!
    private var productSizesOnly: PCFProduct!
    private var productColorsOnly: PCFProduct!
    private var productNoColorsNoSizes: PCFProduct!
    private var productNoSKU: PCFProduct!
    private var color: PCFColor!

    override func setUp() {
        super.setUp()

        do {
            let productJSONData = try TestServer.getJSONData("SingleProduct")
            product = try JSONDecoder().decode(PCFProduct.self, from: productJSONData)
        } catch {
            XCTFail("Can't open Product JSON")
        }
        do {
            let productJSONData = try TestServer.getJSONData("SingleProductOutOfStock")
            productOutOfStock = try JSONDecoder().decode(PCFProduct.self, from: productJSONData)
        } catch {
            XCTFail("Can't open Product JSON")
        }
        do {
            let productJSONData = try TestServer.getJSONData("SingleProductSizesOnly")
            productSizesOnly = try JSONDecoder().decode(PCFProduct.self, from: productJSONData)
        } catch {
            XCTFail("Can't open Product JSON")
        }
        do {
            let productJSONData = try TestServer.getJSONData("SingleProductColorsOnly")
            productColorsOnly = try JSONDecoder().decode(PCFProduct.self, from: productJSONData)
        } catch {
            XCTFail("Can't open Product JSON")
        }
        do {
            let productJSONData = try TestServer.getJSONData("SingleProductNoColorsNoSizes")
            productNoColorsNoSizes = try JSONDecoder().decode(PCFProduct.self, from: productJSONData)
        } catch {
            XCTFail("Can't open Product JSON")
        }
        do {
            let productJSONData = try TestServer.getJSONData("SingleProductNoSKU")
            productNoSKU = try JSONDecoder().decode(PCFProduct.self, from: productJSONData)
        } catch {
            XCTFail("Can't open Product JSON")
        }
        do {
            let colorJSONData = try TestServer.getJSONData("SingleColor")
            color = try JSONDecoder().decode(PCFColor.self, from: colorJSONData)
        } catch {
            XCTFail("Can't open Color JSON")
        }

        dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                             sessionManager: sessionManager,
                                                             httpClient: FakeHTTPClient(jsonName: "SingleProduct"),
                                                             decoder: JSONDecoder())
    }

    override func tearDown() {
        dataManager = nil
        product = nil
        productOutOfStock = nil
        productSizesOnly = nil
        productColorsOnly = nil
        productNoColorsNoSizes = nil
        productNoSKU = nil
        color = nil

        super.tearDown()
    }

    func testGetProduct() {
        let interactor = ProductInteractor(dataManager: dataManager)
        let exp = expectation(description: "testLoadProduct")

        interactor.product(forProductId: "") { (product, error) in
            XCTAssertEqual(product?.resourceId, "1234")
            XCTAssertEqual(product?.name, "Vera")
            XCTAssertEqual(product?.price, 45.0)
            XCTAssertEqual(product?.discountedPrice, 40.0)
            XCTAssertEqual(product?.productDescription, "<p>Gorgeous lace ...")
            XCTAssertNotNil(product?.imageResources)
            XCTAssertTrue(product?.imageIds.count == 2)
            XCTAssertEqual(product?.imageIds[0], "1")
            XCTAssertEqual(product?.imageIds[1], "2")

            XCTAssertNil(error)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetSKU() {
        dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                             sessionManager: sessionManager,
                                                             httpClient: FakeHTTPClient(jsonName: "SingleSKU"),
                                                             decoder: JSONDecoder())
        let interactor = ProductInteractor(dataManager: dataManager)
        let exp = expectation(description: "testLoadSKU")

        interactor.sku(forSKUId: "", productId: "") { (sku, error) in
            XCTAssertEqual(sku?.resourceId, "12345")
            XCTAssertEqual(sku?.price, 45)
            XCTAssertTrue(sku!.isAvailable)
            XCTAssertNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testProductInteractorError() {
        dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                             sessionManager: sessionManager,
                                                             httpClient: FakeHTTPClient(),
                                                             decoder: JSONDecoder())
        let interactor = ProductInteractor(dataManager: dataManager)
        let exp = expectation(description: "testError")

        interactor.product(forProductId: "") { (product, error) in
            XCTAssertNil(product)
            XCTAssertNotNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testProductAllSizes() {
        // Given
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = product
        let sizes = interactor.sizes()
        // When
        let expectedSizesCount = 4
        // Then
        XCTAssertEqual(sizes.count, expectedSizesCount)
    }

    func testProductAllSizes_whenNoSKUIsAvailable() {
        // Given
        let httpClient = FakeHTTPClient(jsonName: "SingleProductNoSKU")
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: httpClient,
                                                                 decoder: JSONDecoder())
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = productNoSKU
        let sizes = interactor.sizes()
        // When
        let expectedSizesCount = 0
        // Then
        XCTAssertEqual(sizes.count, expectedSizesCount)
    }

    func testProductAllColors() {
        // Given
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = product
        let colors = interactor.colors()
        // When
        let expectedColorsCount = 3
        // Then
        XCTAssertEqual(colors.count, expectedColorsCount)
    }

    func testProductAllColors_whenNoSKUIsAvailable() {
        // Given
        let httpClient = FakeHTTPClient(jsonName: "SingleProductNoSKU")
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: httpClient,
                                                                 decoder: JSONDecoder())
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = productNoSKU
        let colors = interactor.colors()
        // When
        let expectedColorsCount = 0
        // Then
        XCTAssertEqual(colors.count, expectedColorsCount)
    }

    func testProductAvailableSizes() {
        // Given
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = product
        let sizes = interactor.availableSizes()
        // When
        let expectedSizesCount = 3
        // Then
        XCTAssertEqual(sizes.count, expectedSizesCount)
    }

    func testProductAvailableSizes_whenNoSKUIsAvailable() {
        // Given
        let httpClient = FakeHTTPClient(jsonName: "SingleProductNoSKU")
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: httpClient,
                                                                 decoder: JSONDecoder())
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = productNoSKU
        let sizes = interactor.availableSizes(forColor: nil)
        // When
        let expectedSizesCount = 0
        // Then
        XCTAssertEqual(sizes.count, expectedSizesCount)
    }

    func testProductAvailableColors() {
        // Given
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = product
        let colors = interactor.availableColors()
        // When
        let expectedColorsCount = 2
        // Then
        XCTAssertEqual(colors.count, expectedColorsCount)
    }

    func testProductAvailableColors_whenNoSKUIsAvailable() {
        // Given
        let httpClient = FakeHTTPClient(jsonName: "SingleProductNoSKU")
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: httpClient,
                                                                 decoder: JSONDecoder())
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = productNoSKU
        let colors = interactor.availableColors()
        // When
        let expectedColorsCount = 0
        // Then
        XCTAssertEqual(colors.count, expectedColorsCount)
    }

    func testProductAvailableSizesForInvalidColor() {
        // Given
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = product
        let sizes = interactor.availableSizes(forColor: nil)
        // When
        let expectedSizesCount = 3
        // Then
        XCTAssertEqual(sizes.count, expectedSizesCount)
    }

    func testProductAvailableSizesForValidColor() {
        // Given
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = product
        let color = self.color
        // When
        let sizes = interactor.availableSizes(forColor: color)
        // Then
        XCTAssertTrue(sizes.count == 3)
        XCTAssertEqual(sizes[0], "1")
        XCTAssertEqual(sizes[1], "2")
        XCTAssertEqual(sizes[2], "3")
    }

    func testProductAvailableColorsForInvalidSize() {
        // Given
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = product
        let colors = interactor.availableColors(forSize: nil)
        // When
        let expectedColorsCount = 2
        // Then
        XCTAssertEqual(colors.count, expectedColorsCount)
    }

    func testProductAvailableColorsForValidSize() {
        // Given
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = product
        let size = "1"
        let colors = interactor.availableColors(forSize: size)
        // When
        let expectedColorsCount = 1
        // Then
        XCTAssertEqual(colors.count, expectedColorsCount)
    }

    func testProductSKUForInvalidColorAndSize() {
        // Given
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = product
        let sku = interactor.sku(forColor: nil, size: nil)
        // Then
        XCTAssertNil(sku)
    }

    func testProductSKUForInvalidColorAndValidSize() {
        // Given
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = product
        let size = "2"
        let sku = interactor.sku(forColor: nil, size: size)
        // Then
        XCTAssertNil(sku)
    }

    func testProductSKUForValidColorAndInvalidSize() {
        // Given
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = product
        let color = self.color
        let sku = interactor.sku(forColor: color, size: nil)
        // Then
        XCTAssertNil(sku)
    }

    func testProductSKUForValidColorAndSize() {
        // Given
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = product
        let color = self.color
        let size = "2"
        let sku = interactor.sku(forColor: color, size: size)
        // When
        let expectedSKUId = "12345"
        let expectedSKUPrice: Float = 45
        let expectedSKUDiscountedPrice: Float = 40
        // Then
        XCTAssertNotNil(sku)
        XCTAssertEqual(sku!.resourceId, expectedSKUId)
        XCTAssertTrue(sku!.isAvailable)
        XCTAssertEqual(sku!.price, expectedSKUPrice)
        XCTAssertEqual(sku!.discountedPrice, expectedSKUDiscountedPrice)
    }

    func testProductSizesOnlySKUForInvalidSize() {
        // Given
        let httpClient = FakeHTTPClient(jsonName: "SingleProductSizesOnly")
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: httpClient,
                                                                 decoder: JSONDecoder())
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = productSizesOnly
        let sku = interactor.sku(forColor: nil, size: nil)
        // Then
        XCTAssertNil(sku)
    }

    func testProductSizesOnlySKUForValidSize() {
        // Given
        let httpClient = FakeHTTPClient(jsonName: "SingleProductSizesOnly")
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: httpClient,
                                                                 decoder: JSONDecoder())
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = productSizesOnly
        let size = "2"
        let sku = interactor.sku(forColor: nil, size: size)
        // When
        let expectedSKUId = "1234567"
        let expectedSKUPrice: Float = 35
        let expectedSKUDiscountedPrice: Float = 30
        // Then
        XCTAssertNotNil(sku)
        XCTAssertEqual(sku!.resourceId, expectedSKUId)
        XCTAssertTrue(sku!.isAvailable)
        XCTAssertEqual(sku!.price, expectedSKUPrice)
        XCTAssertEqual(sku!.discountedPrice, expectedSKUDiscountedPrice)
    }

    func testProductColorsOnlySKUForInvalidColor() {
        // Given
        let httpClient = FakeHTTPClient(jsonName: "SingleProductColorsOnly")
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: httpClient,
                                                                 decoder: JSONDecoder())
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = productColorsOnly
        let sku = interactor.sku(forColor: nil, size: nil)
        // Then
        XCTAssertNil(sku)
    }

    func testProductColorsOnlySKUForValidColor() {
        // Given
        let httpClient = FakeHTTPClient(jsonName: "SingleProductColorsOnly")
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: httpClient,
                                                                 decoder: JSONDecoder())
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = productColorsOnly
        let color = self.color
        let sku = interactor.sku(forColor: color, size: nil)
        // When
        let expectedSKUId = "123459876"
        let expectedSKUPrice: Float = 25
        let expectedSKUDiscountedPrice: Float = 20
        // Then
        XCTAssertNotNil(sku)
        XCTAssertEqual(sku!.resourceId, expectedSKUId)
        XCTAssertTrue(sku!.isAvailable)
        XCTAssertEqual(sku!.price, expectedSKUPrice)
        XCTAssertEqual(sku!.discountedPrice, expectedSKUDiscountedPrice)
    }

    func testProductNoColorsNoSizesSKU() {
        // Given
        let httpClient = FakeHTTPClient(jsonName: "SingleProductNoColorsNoSizes")
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: httpClient,
                                                                 decoder: JSONDecoder())
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = productNoColorsNoSizes
        let sku = interactor.sku(forColor: nil, size: nil)
        // When
        let expectedSKUId = "987654"
        let expectedSKUPrice: Float = 45
        let expectedSKUDiscountedPrice: Float = 40
        // Then
        XCTAssertNotNil(sku)
        XCTAssertEqual(sku!.resourceId, expectedSKUId)
        XCTAssertTrue(sku!.isAvailable)
        XCTAssertEqual(sku!.price, expectedSKUPrice)
        XCTAssertEqual(sku!.discountedPrice, expectedSKUDiscountedPrice)
    }

    func testProductNoSKU() {
        // Given
        let httpClient = FakeHTTPClient(jsonName: "SingleProductNoSKU")
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: httpClient,
                                                                 decoder: JSONDecoder())
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = productNoSKU
        let sku = interactor.sku(forColor: nil, size: nil)
        // Then
        XCTAssertNil(sku)
    }

    func testProductAvailableQuantityForSKU() {
        // Given
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = product
        let color = self.color
        let size = "2"
        let sku = interactor.sku(forColor: color, size: size)
        // When
        let availableQuantity = interactor.availableQuantities(forSKU: sku!)
        let limitedAvailableQuantity = interactor.availableQuantities(forSKU: sku!, limit: 3)
        // Then
        XCTAssertEqual(availableQuantity, [Int](1...5))
        XCTAssertEqual(limitedAvailableQuantity, [Int](1...3))
    }

    func testProductAvailableQuantityForSKU_whenAvailabilityIsNotGiven() {
        // Given
        let httpClient = FakeHTTPClient(jsonName: "SingleProductNoColorsNoSizes")
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: httpClient,
                                                                 decoder: JSONDecoder())
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = productNoColorsNoSizes
        let sku = interactor.sku(forColor: nil, size: nil)
        // When
        let availableQuantity = interactor.availableQuantities(forSKU: sku!)
        let limitedAvailableQuantity = interactor.availableQuantities(forSKU: sku!, limit: 3)
        // Then
        XCTAssertTrue(availableQuantity.isEmpty)
        XCTAssertTrue(limitedAvailableQuantity.isEmpty)
    }

    func testProductIsOutOfStock() {
        //When
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = productOutOfStock
        let isOutOfStock = interactor.isProductOutOfStock()
        // Then
        XCTAssertTrue(isOutOfStock)
    }

    func testProductIsNotOutOfStock() {
        //When
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = product
        let isOutOfStock = interactor.isProductOutOfStock()
        // Then
        XCTAssertFalse(isOutOfStock)
    }

    func testProductIsOutOfStock_whenNoSKUIsAvailable() {
        //When
        let httpClient = FakeHTTPClient(jsonName: "SingleProductNoSKU")
        let dataManager = ProductDataManager<PCFProduct, PCFSku>(environmentManager: envManager,
                                                                 sessionManager: sessionManager,
                                                                 httpClient: httpClient,
                                                                 decoder: JSONDecoder())
        let interactor = ProductInteractor(dataManager: dataManager)
        interactor.product = productNoSKU
        let isOutOfStock = interactor.isProductOutOfStock()
        // Then
        XCTAssertTrue(isOutOfStock)
    }

}
