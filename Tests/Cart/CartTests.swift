//
//  Cart.swift
//  PCFSwift
//
//  Created by Satinder Singh on 7/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import PCFSwift

class CartTests: XCTestCase {

    var cart: PCFCart!
    var cartWithoutDiscount: PCFCart!
    var sku: PCFSku!
    var product: PCFProduct!

    // MARK: - Test Case Life Cycle
    override func setUp() {
        super.setUp()

        // Initalize cart from SingleCart.json
        do {
            let cartJSONData = try TestServer.getJSONData("SingleCart")
            cart = try JSONDecoder().decode(PCFCart.self, from: cartJSONData)
        } catch {
            XCTFail("Can't open SingleCart JSON")
        }

        // Initialize cart with discount from SingleCartNoTotalDiscountedPrice.json
        do {
            let cartWithoutDiscountJSONArrayData = try TestServer.getJSONData("SingleCartNoTotalDiscountedPrice")
            cartWithoutDiscount = try JSONDecoder().decode(PCFCart.self, from: cartWithoutDiscountJSONArrayData)
        } catch {
            XCTFail("Can't open SingleCartNoTotalDiscountedPrice JSON")
        }

        // Initalize sku from Sku.json
        do {
            let skuJSONData = try TestServer.getJSONData("Sku")
            sku = try JSONDecoder().decode(PCFSku.self, from: skuJSONData)
        } catch {
            XCTFail("Can't open Sku JSON")
        }

        // Initalize product from SingleProduct.json
        do {
            let productJSONData = try TestServer.getJSONData("SingleProduct")
            product = try JSONDecoder().decode(PCFProduct.self, from: productJSONData)
        } catch {
            XCTFail("Can't open Sku JSON")
        }
    }

    override func tearDown() {
        cart = nil
        super.tearDown()
    }

    // MARK: - Helper Methods
    func testAdjustment(_ adjustment: Adjustment) {
        XCTAssertEqual(adjustment.resourceId, "210615")
        XCTAssertEqual(adjustment.type, "coupon")
        XCTAssertEqual(adjustment.amount, -9.99)
        XCTAssertEqual(adjustment.code, "SOME_CODE")
        XCTAssertEqual(adjustment.adjustmentDescription, "Save 20% on Furniture")
    }

    // MARK: - Cart
    func testCart() {
        XCTAssertNotNil(cart)
        XCTAssertEqual(cart.itemCount, 1)
        XCTAssertEqual(cart.itemTotalCount, 5)
        XCTAssertEqual(cart.subtotal, 299.99)
        XCTAssertEqual(cart.tax, 9.88)
        XCTAssertEqual(cart.totalAdjustment, -100)
        XCTAssertEqual(cart.total, 199.99)
        XCTAssertEqual(cart.costUntilFreeShipping, 45)

        XCTAssertNotNil(cart.cartItems)
        XCTAssertNotNil(cart.adjustments)
        XCTAssertNotNil(cart.billingAddress)
        XCTAssertFalse(cart.shipments.isEmpty)

        XCTAssertNotNil(cart.customerInformation)
    }

    func testCartAdjustments() {
        let adjustments = cart.adjustments
        XCTAssertEqual(adjustments.count, 1)

        // Given
        let adjustment = adjustments.first!
        // Then
        testAdjustment(adjustment)
    }

    // MARK: - Cart Items
    func testCartItem() {
        let cartItems = cart.cartItems
        XCTAssertTrue(cartItems.count == 1)

        // Given
        let cartItem = cartItems.first!
        // Then
        XCTAssertNotNil(cartItem.adjustments)
        XCTAssertEqual(cartItem.otherSKUsAvailable, true)
        XCTAssertNotNil(cartItem.personalizations)
        XCTAssertNotNil(cartItem.product)
        XCTAssertEqual(cartItem.quantity, 5)
        XCTAssertEqual(cartItem.resourceId, "123456")
        XCTAssertEqual(cartItem.totalDiscountedPrice, 1499.95)
        XCTAssertEqual(cartItem.totalPrice, 1999.95)
    }

    // MARK: - Cart Item With No Discounted Price
    func testCartItemWithoutDiscountedPrice() {
        let cartItems = cartWithoutDiscount.cartItems
        XCTAssertTrue(cartItems.count == 1)

        // Given
        let cartItem = cartItems.first!
        // Then
        XCTAssertNotNil(cartItem.adjustments)
        XCTAssertEqual(cartItem.otherSKUsAvailable, true)
        XCTAssertNotNil(cartItem.personalizations)
        XCTAssertNotNil(cartItem.product)
        XCTAssertEqual(cartItem.quantity, 5)
        XCTAssertEqual(cartItem.resourceId, "123456")
        XCTAssertEqual(cartItem.totalDiscountedPrice, nil)
        XCTAssertEqual(cartItem.totalPrice, 1999.95)
    }

    // MARK: - Cart Item Adjustments
    func testCartItemAdjustments() {
        let adjustments = cart.cartItems.first!.adjustments
        XCTAssertEqual(adjustments.count, 1)

        // Given
        let adjustment = adjustments.first
        // Then
        testAdjustment(adjustment!)
    }

    // MARK: - Cart Item Personalization
    func testCartItemPersonalizations() {
        let personalizations = cart.cartItems.first!.personalizations!
        XCTAssertEqual(personalizations.count, 1)

        // Given
        let personalization = personalizations.first!
        // Then
        XCTAssertEqual(personalization.resourceId, "1")
        XCTAssertEqual(personalization.label, "Thread Color")
        XCTAssertEqual(personalization.type, "string")
        XCTAssertEqual(personalization.instructionsURL, "http://www.url.com")
    }

    func testCartItemPersonalizationOptions() {
        // Given
        let personlization = cart.cartItems.first!.personalizations!.first!
        let options = personlization.options!
        XCTAssertEqual(options.count, 2)
        // Then
        XCTAssertEqual(personlization.resourceId, "1")
        XCTAssertEqual(personlization.label, "Thread Color")
        XCTAssertEqual(personlization.type, "string")
        XCTAssertEqual(personlization.instructionsURL, "http://www.url.com")

        XCTAssertEqual(options[0], "Apple")
        XCTAssertEqual(options[1], "Wisteria")
    }

    // MARK: - Cart Item Product
    func testCartItemProduct() {
        // Given
        let product = cart.cartItems.first!.product
        // Then
        XCTAssertEqual(product.resourceId, "1234")
        XCTAssertEqual(product.name, "Vera")
        XCTAssertEqual(product.price, 45)
        XCTAssertEqual(product.discountedPrice, 40)
        XCTAssertEqual(product.productDescription, "<p>Gorgeous lace ...")
        XCTAssertNotNil(product.imageIds)
        XCTAssertNotNil(product.categoryIds)
        XCTAssertNotNil(product.wishlistIds)
    }

    func testCartItemProductCategoryIds() {
        // Given
        let categoryIds = cart.cartItems.first!.product.categoryIds!
        // Then
        XCTAssertEqual(categoryIds[0], "1")
        XCTAssertEqual(categoryIds[1], "2")
        XCTAssertEqual(categoryIds[2], "5")

    }

    func testCartItemProductImageIds() {
        // Given
        let imageIds = cart.cartItems.first!.product.imageIds
        // Then
        XCTAssertEqual(imageIds[0], "1")
        XCTAssertEqual(imageIds[1], "2")
    }

    func testCartItemProductWishlistIds() {
        // Given
        let wishlistIds = cart.cartItems.first!.product.wishlistIds!
        // Then
        XCTAssertEqual(wishlistIds[0], "1")
        XCTAssertEqual(wishlistIds[1], "2")
        XCTAssertEqual(wishlistIds[2], "5")
    }

    func testCartItemProductImageResources() {
        let imageResources = cart.cartItems.first!.product.imageResources
        XCTAssertEqual(imageResources!.count, 2)
        // Given
        let firstImageResourceList = imageResources!["1"]!
        let secondImageResourceList = imageResources!["2"]!
        // Then
        XCTAssertEqual(firstImageResourceList[0].url.absoluteString, "http://www.url1.jpg")
        XCTAssertEqual(firstImageResourceList[0].usage, "thumbnail")

        XCTAssertEqual(firstImageResourceList[1].url.absoluteString, "http://www.url2.jpg")
        XCTAssertEqual(firstImageResourceList[1].usage, "small")

        XCTAssertEqual(firstImageResourceList[2].url.absoluteString, "http://www.url3.jpg")
        XCTAssertEqual(firstImageResourceList[2].usage, "large")

        XCTAssertEqual(secondImageResourceList[0].url.absoluteString, "http://www.url4.jpg")
        XCTAssertEqual(secondImageResourceList[0].usage, "thumbnail")

        XCTAssertEqual(secondImageResourceList[1].url.absoluteString, "http://www.url6.jpg")
        XCTAssertEqual(secondImageResourceList[1].usage, "large")
    }

    // MARK: - Cart Addresses
    func testBillingAddressForProduct() {
        // Given
        let billingAddress = cart.billingAddress
        // Then
        XCTAssertEqual(billingAddress?.address1, "10001 Johnson St")
        XCTAssertNil(billingAddress?.address2)
        XCTAssertEqual(billingAddress?.city, "Novato")
        XCTAssertEqual(billingAddress?.country, "US")
        XCTAssertEqual(billingAddress?.firstName, "James")
        XCTAssertEqual(billingAddress?.isPrimary, false)
        XCTAssertEqual(billingAddress?.lastName, "Bond")
        XCTAssertEqual(billingAddress?.phone, "4151515555")
        XCTAssertEqual(billingAddress?.resourceId, "1234")
        XCTAssertEqual(billingAddress?.save, false)
        XCTAssertEqual(billingAddress?.state, "CA")
        XCTAssertEqual(billingAddress?.zip, "94949")
    }

    // MARK: - Cart Shipments
    func testShipmentsForProduct() {
        // Given
        let shipment = cart.shipments.first!
        let shippingAddress = shipment.shippingAddress
        let shippingOption = shipment.shippingOption
        // Then
        XCTAssertEqual(shipment.resourceId, "1234")

        XCTAssertEqual(shippingAddress?.address1, "10001 Johnson St")
        XCTAssertNil(shippingAddress?.address2)
        XCTAssertEqual(shippingAddress?.city, "Novato")
        XCTAssertEqual(shippingAddress?.country, "US")
        XCTAssertEqual(shippingAddress?.firstName, "James")
        XCTAssertEqual(shippingAddress?.isPrimary, false)
        XCTAssertEqual(shippingAddress?.lastName, "Bond")
        XCTAssertEqual(shippingAddress?.phone, "4151515555")
        XCTAssertEqual(shippingAddress?.resourceId, "1234")
        XCTAssertEqual(shippingAddress?.save, true)
        XCTAssertEqual(shippingAddress?.state, "CA")
        XCTAssertEqual(shippingAddress?.zip, "94949")

        XCTAssertEqual(shippingOption?.name, "standard (4-5 days)")
        XCTAssertEqual(shippingOption?.price, 10.0)
        XCTAssertEqual(shippingOption?.resourceId, "1")
    }

    // MARK: - Cart Customer Information
    func testCartCustomerInformation() {
        // Given
        let customerInformation = cart.customerInformation
        // Then
        XCTAssertEqual(customerInformation?.customerNumber, "12344234")
        XCTAssertEqual(customerInformation?.email, "john@doe.com")
    }

    // MARK: - Cart Payment Methods
    func testCartPaymentMethods() {
        // Given
        let paymentMethods = cart.paymentMethods
        let paymentMethod = paymentMethods.first
        // Then
        XCTAssertTrue(paymentMethods.count > 0)
        XCTAssertNotNil(paymentMethod)
    }

    // MARK: - Cart Methods
    func testQuantityForProduct() {
        // Given
        let quantity = cart.quantity(forProduct: product)
        // Then
        XCTAssertEqual(quantity, 5)
    }

    func testQuantityForSku() {
        // Given
        let quantity = cart.quantity(forSKU: sku)
        // Then
        XCTAssertEqual(quantity, 5)
    }

    func testCartItemForSku() {
        // Given
        let cartItem = cart.cartItem(forSKU: sku.resourceId)
        let nonExistentCartItem = cart.cartItem(forSKU: "0")
        // Then
        XCTAssertNotNil(cartItem)
        XCTAssertNil(nonExistentCartItem)
    }

}
