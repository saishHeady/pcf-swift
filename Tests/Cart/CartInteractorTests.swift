//
//  CartInteractorTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class CartInteractorTests: BaseTestDataManager {

    private var dataManager: CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>!
    private var cart: PCFCart!

    override func setUp() {
        super.setUp()

        do {
            let cartJSONData = try TestServer.getJSONData("SingleCart")
            cart = try JSONDecoder().decode(PCFCart.self, from: cartJSONData)
        } catch {
            XCTFail("Can't open Cart JSON")
        }

        dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                  sessionManager: sessionManager,
                                                                                  httpClient: FakeHTTPClient(jsonName: "SingleCart"))
    }

    override func tearDown() {
        dataManager = nil
        cart = nil

        super.tearDown()
    }

    func testGetCart() {
        let interactor = CartInteractor(dataManager: dataManager)
        let exp = expectation(description: "testLoadCart")

        interactor.cart { (cart, error) in
            XCTAssertNotNil(cart)
            XCTAssertEqual(cart?.itemCount, 1)
            XCTAssertEqual(cart?.itemTotalCount, 5)
            XCTAssertEqual(cart?.subtotal, 299.99)
            XCTAssertEqual(cart?.tax, 9.88)
            XCTAssertEqual(cart?.totalAdjustment, -100)
            XCTAssertEqual(cart?.total, 199.99)
            XCTAssertEqual(cart?.costUntilFreeShipping, 45)
            XCTAssertNotNil(cart?.cartItems)
            XCTAssertNotNil(cart?.adjustments)

            XCTAssertNil(error)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testAddToCart() {
        let httpClient = FakeHTTPClient(jsonName: "SingleCartWithNewItem")
        dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                  sessionManager: sessionManager,
                                                                                  httpClient: httpClient)
        let interactor = CartInteractor(dataManager: dataManager)
        let exp = expectation(description: "testAddToCart")
        let itemToAdd = AddToCartParameters(productId: "12345", quantity: 1, skuId: "98765", personalizations: [])

        interactor.add(items: [itemToAdd]) { (cart, error) in
            XCTAssertNotNil(cart)
            XCTAssertEqual(cart?.itemCount, 2)
            XCTAssertEqual(cart?.itemTotalCount, 6)
            XCTAssertEqual(cart?.subtotal, 599.98)
            XCTAssertEqual(cart?.tax, 19.76)
            XCTAssertEqual(cart?.totalAdjustment, -100)
            XCTAssertEqual(cart?.total, 519.74)

            guard let addedItem = cart?.cartItems[1] else {
                XCTFail("Error in \(#function)")
                return
            }

            XCTAssertEqual(addedItem.product.resourceId, "12345")
            XCTAssertEqual(addedItem.sku?.resourceId, "98765")

            XCTAssertNil(error)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testUpdateItemInCart() {
        let httpClient = FakeHTTPClient(jsonName: "SingleUpdatedCart")
        dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                  sessionManager: sessionManager,
                                                                                  httpClient: httpClient)
        let interactor = CartInteractor(dataManager: dataManager)
        let updateItem = UpdateCartParameters(productId: "12345", quantity: 3)
        let exp = expectation(description: "testUpdateCart")

        interactor.update(items: [updateItem]) { (cart, error) in
            XCTAssertNotNil(cart)
            XCTAssertEqual(cart?.itemCount, 1)
            XCTAssertEqual(cart?.itemTotalCount, 3)

            XCTAssertNil(error)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    // swiftlint:disable line_length
    func testRemoveItemFromCart_callsUpdateWithZeroQuantity() {
        let httpClient = FakeHTTPClient(jsonName: "SingleUpdatedCart")
        dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                  sessionManager: sessionManager,
                                                                                  httpClient: httpClient)
        let loggingInteractor = LoggingCartInteractor(dataManager: dataManager)
        let exp = expectation(description: "testRemoveItemCart")

        loggingInteractor.removeItem("12345") { (_, _) in
            XCTAssertTrue(loggingInteractor.wasUpdateCalled)
            XCTAssertEqual(loggingInteractor.parametersForUpdateCall.count, 1)
            XCTAssertEqual(loggingInteractor.parametersForUpdateCall.first! as? UpdateCartParameters, UpdateCartParameters(productId: "12345", quantity: 0))

            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testAdjustmentInCart() {
        let httpClient = FakeHTTPClient(jsonName: "SingleCartWithAddedAdjustment")
        dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                  sessionManager: sessionManager,
                                                                                  httpClient: httpClient)
        let interactor = CartInteractor(dataManager: dataManager)
        let exp = expectation(description: "testAdjustmentCart")

        interactor.adjustment(type: "promo", code: "FREESHIPPING") { (cart, error) in
            XCTAssertNotNil(cart)
            XCTAssertTrue(cart?.adjustments.count == 2)

            guard let newAdjustment = cart?.adjustments[1] else {
                XCTFail("Error in \(#function)")
                return
            }

            XCTAssertEqual(newAdjustment.type, "promo")
            XCTAssertEqual(newAdjustment.code, "FREESHIPPING")

            XCTAssertNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testShippingOptionsFromCart() {
        let httpClient = FakeHTTPClient(jsonName: "ShippingOptions")
        dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                  sessionManager: sessionManager,
                                                                                  httpClient: httpClient)
        let interactor = CartInteractor(dataManager: dataManager)
        let exp = expectation(description: "testAdjustmentCart")

        interactor.shippingOptions(shipmentId: "123") { (options, error) in
            XCTAssertTrue(options.count == 1)

            let firstOption = options.first
            XCTAssertEqual(firstOption?.resourceId, "1")
            XCTAssertEqual(firstOption?.name, "standard (4-5 days)")
            XCTAssertEqual(firstOption?.price, 0)

            XCTAssertNil(error)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testPlaceOrder() {
        let httpClient = FakeHTTPClient(jsonName: "SingleOrderDetail")
        dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                  sessionManager: sessionManager,
                                                                                  httpClient: httpClient)
        let interactor = CartInteractor(dataManager: dataManager)
        let exp = expectation(description: "testAdjustmentCart")

        interactor.placeOrder { (order, error) in
            XCTAssertNotNil(order)
            XCTAssertNil(error)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testPaymentMethodsFiltering_whenLookingForCreditCard() {
        let httpClient = FakeHTTPClient(jsonName: "SingleCartWithMultiplePaymentMethods")
        dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                  sessionManager: sessionManager,
                                                                                  httpClient: httpClient)
        let interactor = CartInteractor(dataManager: dataManager)

        let exp = expectation(description: "testPaymentMethodsFiltering")

        interactor.cart { (cart, error) in
            XCTAssertNotNil(cart)

            let creditCards = interactor.paymentMethods(ofType: "card")
            XCTAssertTrue(creditCards.count > 0)
            XCTAssertEqual(creditCards[0].resourceId, "12345")
            XCTAssertEqual(creditCards[0].type, "card")
            XCTAssertEqual(creditCards[0].paymentObject.number, "************1111")
            XCTAssertNotNil(creditCards[0].paymentObject.cardType)
            XCTAssertNotNil(creditCards[0].paymentObject.nameOnCard)
            XCTAssertNotNil(creditCards[0].paymentObject.expirationYear)
            XCTAssertNotNil(creditCards[0].paymentObject.expirationMonth)

            XCTAssertNil(error)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testPaymentMethodsFiltering_whenLookingForGiftCard() {
        let httpClient = FakeHTTPClient(jsonName: "SingleCartWithMultiplePaymentMethods")
        dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                  sessionManager: sessionManager,
                                                                                  httpClient: httpClient)
        let interactor = CartInteractor(dataManager: dataManager)

        let exp = expectation(description: "testPaymentMethodsFiltering")

        interactor.cart { (cart, error) in
            XCTAssertNotNil(cart)

            let creditCards = interactor.paymentMethods(ofType: "gift_card")
            XCTAssertTrue(creditCards.count > 0)
            XCTAssertEqual(creditCards[0].resourceId, "54321")
            XCTAssertEqual(creditCards[0].type, "gift_card")
            XCTAssertEqual(creditCards[0].paymentObject.number, "578234782784")
            XCTAssertNil(creditCards[0].paymentObject.cardType)
            XCTAssertNil(creditCards[0].paymentObject.nameOnCard)
            XCTAssertNil(creditCards[0].paymentObject.expirationYear)
            XCTAssertNil(creditCards[0].paymentObject.expirationMonth)

            XCTAssertNil(error)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testPaymentMethodsFiltering_whenNoPaymentMethodIsFound() {
        let httpClient = FakeHTTPClient(jsonName: "SingleCartWithMultiplePaymentMethods")
        dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                  sessionManager: sessionManager,
                                                                                  httpClient: httpClient)
        let interactor = CartInteractor(dataManager: dataManager)

        let exp = expectation(description: "testPaymentMethodsFiltering")

        interactor.cart { (cart, error) in
            XCTAssertNotNil(cart)

            let creditCards = interactor.paymentMethods(ofType: "fake_type")
            XCTAssertTrue(creditCards.count == 0)

            XCTAssertNil(error)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testPaymentMethodsFiltering_whenCartIsNil() {
        let httpClient = FakeHTTPClient(jsonName: "SingleCartWithMultiplePaymentMethods")
        dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                  sessionManager: sessionManager,
                                                                                  httpClient: httpClient)
        let interactor = CartInteractor(dataManager: dataManager)
        let creditCards = interactor.paymentMethods(ofType: "fake_type")
        XCTAssertTrue(creditCards.count == 0)
    }

}
