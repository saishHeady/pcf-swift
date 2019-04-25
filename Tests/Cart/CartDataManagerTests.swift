//
//  CartDataManagerTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/4/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

// swiftlint:disable file_length
class CartDataManagerTests: BaseTestDataManager {

    var validDataManager: CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>!

    override func setUp() {
        super.setUp()

        let validResponseClient = FakeHTTPClient(jsonName: "SingleCart")
        validDataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                       sessionManager: sessionManager,
                                                                                       httpClient: validResponseClient)
    }

    override func tearDown() {
        validDataManager = nil

        super.tearDown()
    }

    func testCartValidResponse() {
        let validResponseClient = FakeHTTPClient(jsonName: "SingleCart")
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: validResponseClient)
        let exp = expectation(description: "response expectation")

        dataManager.cart { (cart, error) in
            guard error == nil else {
                XCTFail("Expected valid response and no errors, got error: \(String(describing: error))")
                return
            }
            guard let cart = cart else {
                XCTFail("Expected valid response, got nil product")
                return
            }

            XCTAssertEqual(cart.itemCount, 1)
            XCTAssertEqual(cart.itemTotalCount, 5)
            XCTAssertEqual(cart.subtotal, 299.99)
            XCTAssertEqual(cart.tax, 9.88)
            XCTAssertEqual(cart.totalAdjustment, -100)
            XCTAssertEqual(cart.total, 199.99)
            XCTAssertEqual(cart.costUntilFreeShipping, 45)
            XCTAssertNotNil(cart.cartItems)
            XCTAssertNotNil(cart.adjustments)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testAddToCartValidResponse() {
        let validResponseClient = FakeHTTPClient(jsonName: "SingleCart")
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: validResponseClient)
        let exp = expectation(description: "response expectation")

        let cartItem = AddToCartParameters(productId: "1234", quantity: 1, skuId: "12345", personalizations: [])

        dataManager.add(items: [cartItem]) { (cart, error) in
            guard error == nil else {
                XCTFail("Expected valid response and no errors, got error: \(String(describing: error))")
                return
            }
            guard let cart = cart else {
                XCTFail("Expected valid response, got nil product")
                return
            }

            XCTAssertEqual(cart.itemCount, 1)
            XCTAssertEqual(cart.itemTotalCount, 5)
            XCTAssertEqual(cart.subtotal, 299.99)
            XCTAssertEqual(cart.tax, 9.88)
            XCTAssertEqual(cart.totalAdjustment, -100)
            XCTAssertEqual(cart.total, 199.99)
            XCTAssertEqual(cart.costUntilFreeShipping, 45)
            XCTAssertNotNil(cart.cartItems)
            XCTAssertNotNil(cart.adjustments)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testUpdateCartValidResponse() {
        let validResponseClient = FakeHTTPClient(jsonName: "SingleCart")
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: validResponseClient)
        let exp = expectation(description: "response expectation")

        let updateCartItem = UpdateCartParameters(productId: "12345", quantity: 1)

        dataManager.update(items: [updateCartItem]) { (cart, error) in
            guard error == nil else {
                XCTFail("Expected valid response and no errors, got error: \(String(describing: error))")
                return
            }
            guard let cart = cart else {
                XCTFail("Expected valid response, got nil product")
                return
            }

            XCTAssertEqual(cart.itemCount, 1)
            XCTAssertEqual(cart.itemTotalCount, 5)
            XCTAssertEqual(cart.subtotal, 299.99)
            XCTAssertEqual(cart.tax, 9.88)
            XCTAssertEqual(cart.totalAdjustment, -100)
            XCTAssertEqual(cart.total, 199.99)
            XCTAssertEqual(cart.costUntilFreeShipping, 45)
            XCTAssertNotNil(cart.cartItems)
            XCTAssertNotNil(cart.adjustments)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testAdjustmentCartValidResponse() {
        let validResponseClient = FakeHTTPClient(jsonName: "SingleCart")
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: validResponseClient)
        let exp = expectation(description: "response expectation")

        dataManager.adjustment(type: "", code: "") { (cart, error) in
            guard error == nil else {
                XCTFail("Expected valid response and no errors, got error: \(String(describing: error))")
                return
            }
            guard let cart = cart else {
                XCTFail("Expected valid response, got nil product")
                return
            }

            XCTAssertEqual(cart.itemCount, 1)
            XCTAssertEqual(cart.itemTotalCount, 5)
            XCTAssertEqual(cart.subtotal, 299.99)
            XCTAssertEqual(cart.tax, 9.88)
            XCTAssertEqual(cart.totalAdjustment, -100)
            XCTAssertEqual(cart.total, 199.99)
            XCTAssertEqual(cart.costUntilFreeShipping, 45)
            XCTAssertNotNil(cart.cartItems)
            XCTAssertNotNil(cart.adjustments)

            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testShippingOptionsCartValidResponse() {
        let validResponseClient = FakeHTTPClient(jsonName: "ShippingOptions")
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: validResponseClient)
        let exp = expectation(description: "response expectation")

        dataManager.shippingOptions(shipmentId: "123") { (shippingOptions, error) in
            guard error == nil else {
                XCTFail("Expected valid response and no errors, got error: \(String(describing: error))")
                return
            }

            let option = shippingOptions.first
            XCTAssertEqual(option?.resourceId, "1")
            XCTAssertEqual(option?.name, "standard (4-5 days)")
            XCTAssertEqual(option?.price, 0)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testInvalidResponse() {
        let invalidResponseClient = FakeHTTPClient(jsonName: "SingleError")
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: invalidResponseClient)

        let exp = expectation(description: "response expectation")
        dataManager.cart { (_, error) in
            guard let error = error else {
                XCTFail("Expected an error")
                return
            }

            XCTAssertTrue(error is PCFError)
            XCTAssertEqual(error as? PCFError, PCFError.invalidJSON)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }

            XCTFail(error.localizedDescription)
        }
    }

    func testAddToCartItemParameters() {
        // Given
        let personalizationOption = AddToCartPersonalizationsParameters(resourceId: "1234",
                                                                        label: "Name",
                                                                        selectedValue: "Batman")
        let cartItem = AddToCartParameters(productId: "1234",
                                           quantity: 1,
                                           skuId: "12345",
                                           personalizations: [personalizationOption])
        let parameters = cartItem.toParameters()

        // When
        guard let product = parameters["product"] as? Parameters,
            let sku = parameters["sku"] as? Parameters,
            let personalizations = parameters["personalizations"] as? [Parameters] else {
                XCTFail("Error in \(#function)")
                return
        }

        let option = personalizations.first

        // Then
        XCTAssertEqual(cartItem.productId, product["id"] as? String)
        XCTAssertEqual(cartItem.quantity, parameters["quantity"] as? Int)
        XCTAssertEqual(cartItem.skuId, sku["id"] as? String)
        XCTAssertFalse(personalizations.isEmpty)
        XCTAssertEqual(personalizationOption.resourceId, option?["id"] as? String)
        XCTAssertEqual(personalizationOption.label, option?["label"] as? String)
        XCTAssertEqual(personalizationOption.selectedValue, option?["selectedValue"] as? String)
    }

    func testUpdateCartItemParameters() {
        // Given
        let updateCartItem = UpdateCartParameters(productId: "12345", quantity: 1)

        // When
        let parameters = updateCartItem.toParameters()

        // Then
        XCTAssertEqual(updateCartItem.productId, parameters["id"] as? String)
        XCTAssertEqual(updateCartItem.quantity, parameters["quantity"] as? Int)
    }

    // MARK: Request Definitions

    func testGetCartPath() {
        let actual = validDataManager.getCartPath()
        let expected = "/cart"

        XCTAssertEqual(actual, expected)
    }

    func testAddToCartPath() {
        let actual = validDataManager.addToCartPath()
        let expected = "/cart"

        XCTAssertEqual(actual, expected)
    }

    func testUpdateCartPath() {
        let actual = validDataManager.updateCartPath()
        let expected = "/cart"

        XCTAssertEqual(actual, expected)
    }

    func testAddShippingAddressPath() {
        let shipmentId = "123"
        let actual = validDataManager.addShippingAddressToCartPath(shipmentId: shipmentId)
        let expected = "/cart/shipments/123/shipping_address"

        XCTAssertEqual(actual, expected)
    }

    func testAddBillingAddrssPath() {
        let actual = validDataManager.addBillingAddressToCartPath()
        let expected = "/cart/billing_address"

        XCTAssertEqual(actual, expected)
    }

    func testShippingOptionsPath() {
        let shipmentId = "123"
        let actual = validDataManager.shippingOptionsForCartPath(shipmentId: shipmentId)
        let expected = "/cart/shipments/123/shipping_options"

        XCTAssertEqual(actual, expected)
    }

    func testAddShippingAddressRequest_withExisitingAddress() {
        let shipmentId = "123"
        let addressId = "Home"
        let request = validDataManager.addShippingAddressToCartRequest(shipmentId: shipmentId,
                                                                       addressId: addressId,
                                                                       useAsBillingAddress: true)

        XCTAssertEqual(request.method, .put)
        XCTAssertEqual(request.baseURL.absoluteString, "http://qa.api.io")
        XCTAssertEqual(request.path, "/cart/shipments/123/shipping_address")
        XCTAssertEqual(request.queryItems?["addressId"], addressId)
        XCTAssertEqual(request.queryItems?["useAsBilling"], "true")
        XCTAssertNil(request.parameters)
        XCTAssertEqual(request.headers?["Content-Type"], "application/json; charset=utf-8")
    }

    func testAddShippingAddressRequest_withNewAddress() {
        let shipmentId = "123"
        let address = AddToCartAddressParameters(firstName: "Jane",
                                                 lastName: "Jones",
                                                 address1: "123 ABC St",
                                                 address2: "Apt 1",
                                                 city: "Brooklyn",
                                                 state: "NY",
                                                 zip: "12345",
                                                 country: "US",
                                                 phone: "2121234567",
                                                 save: false)
        let request = validDataManager.addShippingAddressToCartRequest(shipmentId: shipmentId,
                                                                       shippingAddress: address,
                                                                       useAsBillingAddress: true)

        XCTAssertEqual(request.method, .put)
        XCTAssertEqual(request.baseURL.absoluteString, "http://qa.api.io")
        XCTAssertEqual(request.path, "/cart/shipments/123/shipping_address")
        XCTAssertEqual(request.queryItems?["useAsBilling"], "true")
        XCTAssertEqual(request.parameters?["firstName"] as? String, "Jane")
        XCTAssertEqual(request.parameters?["lastName"] as? String, "Jones")
        XCTAssertEqual(request.parameters?["address1"] as? String, "123 ABC St")
        XCTAssertEqual(request.parameters?["address2"] as? String, "Apt 1")
        XCTAssertEqual(request.parameters?["city"] as? String, "Brooklyn")
        XCTAssertEqual(request.parameters?["state"] as? String, "NY")
        XCTAssertEqual(request.parameters?["zip"] as? String, "12345")
        XCTAssertEqual(request.parameters?["country"] as? String, "US")
        XCTAssertEqual(request.parameters?["phone"] as? String, "2121234567")
        XCTAssertEqual(request.parameters?["save"] as? Bool, false)
        XCTAssertEqual(request.headers?["Content-Type"], "application/json; charset=utf-8")
    }

    func testAddBillingAddressRequest_withExistingAddress() {
        let addressId = "Home"
        let request = validDataManager.addBillingAddressToCartRequest(addressId: addressId,
                                                                      useAsShippingAddress: true)

        XCTAssertEqual(request.method, .put)
        XCTAssertEqual(request.baseURL.absoluteString, "http://qa.api.io")
        XCTAssertEqual(request.path, "/cart/billing_address")
        XCTAssertEqual(request.queryItems?["addressId"], addressId)
        XCTAssertEqual(request.queryItems?["useAsShipping"], "true")
        XCTAssertNil(request.parameters)
        XCTAssertEqual(request.headers?["Content-Type"], "application/json; charset=utf-8")
    }

    func testAddBillingAddressRequest_withNewAddress() {
        let address = AddToCartAddressParameters(firstName: "Jane",
                                                 lastName: "Jones",
                                                 address1: "123 ABC St",
                                                 address2: "Apt 1",
                                                 city: "Brooklyn",
                                                 state: "NY",
                                                 zip: "12345",
                                                 country: "US",
                                                 phone: "2121234567",
                                                 save: false)
        let request = validDataManager.addBillingAddressToCartRequest(billingAddress: address,
                                                                      useAsShippingAddress: true)

        XCTAssertEqual(request.method, .put)
        XCTAssertEqual(request.baseURL.absoluteString, "http://qa.api.io")
        XCTAssertEqual(request.path, "/cart/billing_address")
        XCTAssertEqual(request.queryItems?["useAsShipping"], "true")
        XCTAssertEqual(request.parameters?["firstName"] as? String, "Jane")
        XCTAssertEqual(request.parameters?["lastName"] as? String, "Jones")
        XCTAssertEqual(request.parameters?["address1"] as? String, "123 ABC St")
        XCTAssertEqual(request.parameters?["address2"] as? String, "Apt 1")
        XCTAssertEqual(request.parameters?["city"] as? String, "Brooklyn")
        XCTAssertEqual(request.parameters?["state"] as? String, "NY")
        XCTAssertEqual(request.parameters?["zip"] as? String, "12345")
        XCTAssertEqual(request.parameters?["country"] as? String, "US")
        XCTAssertEqual(request.parameters?["phone"] as? String, "2121234567")
        XCTAssertEqual(request.parameters?["save"] as? Bool, false)
        XCTAssertEqual(request.headers?["Content-Type"], "application/json; charset=utf-8")
    }

    func testGetShippingOptionsRequest() {
        let shipmentId = "123"
        let path = validDataManager.shippingOptionsForCartPath(shipmentId: shipmentId)
        let request = validDataManager.shippingOptionsCartRequest(forPath: path)

        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.baseURL.absoluteString, "http://qa.api.io")
        XCTAssertEqual(request.path, "/cart/shipments/123/shipping_options")
        XCTAssertNil(request.queryItems)
        XCTAssertNil(request.parameters)
        XCTAssertEqual(request.headers?["Content-Type"], "application/json; charset=utf-8")
    }

    func testSetShippingOptionRequest() {
        let shipmentId = "123"
        let shippingOption = SetCartShippingOptionParameters(shippingOptionId: "456")
        let request = validDataManager.setShippingOptionForCartRequest(shipmentId: shipmentId,
                                                                       shippingOption: shippingOption)

        XCTAssertEqual(request.method, .put)
        XCTAssertEqual(request.baseURL.absoluteString, "http://qa.api.io")
        XCTAssertEqual(request.path, "/cart/shipments/123/shipping_options")
        XCTAssertNil(request.queryItems)
        XCTAssertEqual(request.parameters?["id"] as? String, "456")
        XCTAssertEqual(request.headers?["Content-Type"], "application/json; charset=utf-8")
    }

    func testPlaceOrderPath() {
        let actual = validDataManager.placeOrderPath()
        let expected = "/cart/place_order"

        XCTAssertEqual(actual, expected)
    }

}
