//
//  CartDataManagerRequestTests.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/4/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class CartDataManagerRequestTests: BaseTestDataManager {

    func testGetCartRequest() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: validResponseClient)
        let request = dataManager.getCartRequest()
        let headers = dataManager.headers(forEnvironment: envManager.currentEnvironment)
        // When
        let expectedRequest = HTTPRequest(method: .get,
                                          baseURL: envManager.currentEnvironment.baseURL,
                                          path: "/cart",
                                          queryItems: nil,
                                          parameters: nil,
                                          headers: headers)
        // Then
        XCTAssertEqual(request.baseURL, expectedRequest.baseURL)
        XCTAssertEqual(request.method, expectedRequest.method)
        XCTAssertEqual(request.endpoint, expectedRequest.endpoint)
        XCTAssertEqual(request.path, expectedRequest.path)
        XCTAssertEqual(request.headers!, expectedRequest.headers!)
    }

    func testAddToCartRequest() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: validResponseClient)
        let personalizationOption = AddToCartPersonalizationsParameters(resourceId: "1234",
                                                                        label: "Name",
                                                                        selectedValue: "Batman")
        let cartItem = AddToCartParameters(productId: "1234",
                                           quantity: 1,
                                           skuId: "12345",
                                           personalizations: [personalizationOption])
        let parameters = cartItem.toParameters()
        let request = dataManager.addToCartRequest(forPath: "/cart", parameters: parameters)
        let headers = dataManager.headers(forEnvironment: envManager.currentEnvironment)
        // When
        let expectedRequest = HTTPRequest(method: .post,
                                          baseURL: envManager.currentEnvironment.baseURL,
                                          path: "/cart",
                                          queryItems: nil,
                                          parameters: parameters,
                                          headers: headers)
        // Then
        XCTAssertEqual(request.baseURL, expectedRequest.baseURL)
        XCTAssertEqual(request.method, expectedRequest.method)
        XCTAssertEqual(request.endpoint, expectedRequest.endpoint)
        XCTAssertEqual(request.path, expectedRequest.path)
        XCTAssertEqual(request.headers!, expectedRequest.headers!)
    }

    func testUpdateCartRequest() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: validResponseClient)

        let updateCartItem = UpdateCartParameters(productId: "12345", quantity: 1)
        let parameters = updateCartItem.toParameters()
        let request = dataManager.updateCartRequest(forPath: "/cart", parameters: parameters)
        let headers = dataManager.headers(forEnvironment: envManager.currentEnvironment)
        // When
        let expectedRequest = HTTPRequest(method: .put,
                                          baseURL: envManager.currentEnvironment.baseURL,
                                          path: "/cart",
                                          queryItems: nil,
                                          parameters: parameters,
                                          headers: headers)
        // Then
        XCTAssertEqual(request.baseURL, expectedRequest.baseURL)
        XCTAssertEqual(request.method, expectedRequest.method)
        XCTAssertEqual(request.endpoint, expectedRequest.endpoint)
        XCTAssertEqual(request.path, expectedRequest.path)
        XCTAssertEqual(request.headers!, expectedRequest.headers!)
    }

    func testAdjustmentCartRequest() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: validResponseClient)
        let request = dataManager.applyAdjustmentRequest(type: "", code: "")
        let headers = dataManager.headers(forEnvironment: envManager.currentEnvironment)
        // When
        let expectedRequest = HTTPRequest(method: .post,
                                          baseURL: envManager.currentEnvironment.baseURL,
                                          path: "/cart",
                                          queryItems: nil,
                                          parameters: ["type": "", "code": ""],
                                          headers: headers)
        // Then
        XCTAssertEqual(request.baseURL, expectedRequest.baseURL)
        XCTAssertEqual(request.method, expectedRequest.method)
        XCTAssertEqual(request.endpoint, expectedRequest.endpoint)
        XCTAssertEqual(request.path, expectedRequest.path)
        XCTAssertEqual(request.headers!, expectedRequest.headers!)
    }

    func testRemoveAdjustmentCartRequest() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: validResponseClient)
        let request = dataManager.removeAdjustmentRequest(code: "ABC123")
        let headers = dataManager.headers(forEnvironment: envManager.currentEnvironment)
        // When
        let expectedRequest = HTTPRequest(method: .delete,
                                          baseURL: envManager.currentEnvironment.baseURL,
                                          path: "/cart/adjustment/ABC123",
                                          queryItems: nil,
                                          parameters: nil,
                                          headers: headers)
        // Then
        XCTAssertEqual(request.baseURL, expectedRequest.baseURL)
        XCTAssertEqual(request.method, expectedRequest.method)
        XCTAssertEqual(request.endpoint, expectedRequest.endpoint)
        XCTAssertEqual(request.path, expectedRequest.path)
        XCTAssertEqual(request.headers!, expectedRequest.headers!)
    }

    func testShippingOptionsCartRequest() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: validResponseClient)

        let request = dataManager.shippingOptionsCartRequest(forPath: "/cart/shippingoptions")
        let headers = dataManager.headers(forEnvironment: envManager.currentEnvironment)
        // When
        let expectedRequest = HTTPRequest(method: .get,
                                          baseURL: envManager.currentEnvironment.baseURL,
                                          path: "/cart/shippingoptions",
                                          queryItems: nil,
                                          parameters: nil,
                                          headers: headers)
        // Then
        XCTAssertEqual(request.baseURL, expectedRequest.baseURL)
        XCTAssertEqual(request.method, expectedRequest.method)
        XCTAssertEqual(request.endpoint, expectedRequest.endpoint)
        XCTAssertEqual(request.path, expectedRequest.path)
        XCTAssertEqual(request.headers!, expectedRequest.headers!)
    }

    func testAddPaymentMethodCartRequest() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: validResponseClient)
        let paymentObjectRequest = AddPaymentObjectParameters(number: "************1111",
                                                              cardType: "Visa",
                                                              nameOnCard: "John Snow",
                                                              expirationMonth: 1,
                                                              expirationYear: 2020)
        let paymentMethodRequest = AddPaymentMethodParameters(type: "card", paymentObject: paymentObjectRequest)
        let request = dataManager.addPaymentMethodToCartRequest(paymentMethod: paymentMethodRequest)
        let headers = dataManager.headers(forEnvironment: envManager.currentEnvironment)
        // When
        let expectedRequest = HTTPRequest(method: .post,
                                          baseURL: envManager.currentEnvironment.baseURL,
                                          path: "/cart/payment_methods",
                                          queryItems: nil,
                                          parameters: paymentMethodRequest.toParameters(),
                                          headers: headers)

        // Then
        XCTAssertEqual(request.baseURL, expectedRequest.baseURL)
        XCTAssertEqual(request.method, expectedRequest.method)
        XCTAssertEqual(request.endpoint, expectedRequest.endpoint)
        XCTAssertEqual(request.path, expectedRequest.path)
        XCTAssertEqual(request.headers!, expectedRequest.headers!)
    }

    func testPlaceOrderRequest() {
        // Given
        let validResponseClient = FakeHTTPClient()
        let dataManager = CartDataManager<PCFCart, PCFOrderDetail, PCFShippingOption>(environmentManager: envManager,
                                                                                      sessionManager: sessionManager,
                                                                                      httpClient: validResponseClient)

        let request = dataManager.placeOrderRequest()
        let headers = dataManager.headers(forEnvironment: envManager.currentEnvironment)
        // When
        let expectedRequest = HTTPRequest(method: .post,
                                          baseURL: envManager.currentEnvironment.baseURL,
                                          path: dataManager.placeOrderPath(),
                                          queryItems: nil,
                                          parameters: nil,
                                          headers: headers)

        // Then
        XCTAssertEqual(request.baseURL, expectedRequest.baseURL)
        XCTAssertEqual(request.method, expectedRequest.method)
        XCTAssertEqual(request.endpoint, expectedRequest.endpoint)
        XCTAssertEqual(request.path, expectedRequest.path)
        XCTAssertEqual(request.headers!, expectedRequest.headers!)
    }

}
