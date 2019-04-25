//
//  ProductInteractor.swift
//  PCFSwift
//
//  Created by Thibault Klein on 3/22/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Default PCF product interactor.
open class ProductInteractor<ProductType: Product & Swift.Decodable, SkuType: Sku & Swift.Decodable> {

    public let dataManager: ProductDataManager<ProductType, SkuType>
    public var product: ProductType?

    /// Creates a PCFProductInteractor with the given data manager.
    ///
    /// - Parameter dataManager: The data manager used for network communication.
    public init(dataManager: ProductDataManager<ProductType, SkuType>) {
        self.dataManager = dataManager
    }

    /// Fetches the product with the given product id.
    ///
    /// - Parameters:
    ///   - productId: The product id to use.
    ///   - completion: Completion block for the response of getting the full product.
    open func product(forProductId productId: String,
                      completion: @escaping (_ product: ProductType?, _ error: Swift.Error?) -> Void) {
        dataManager.product(forProductId: productId) { [weak self] (product, error) in
            self?.product = product
            completion(product, error)
        }
    }

    /// Fetches the SKU with the given SKU id and product id.
    ///
    /// - Parameters:
    ///   - skuId: The SKU id to use.
    ///   - productId: The product id to use.
    ///   - completion: The completion block.
    open func sku(forSKUId skuId: String,
                  productId: String,
                  completion: @escaping (_ sku: SkuType?, _ error: Swift.Error?) -> Void) {
        dataManager.sku(forSkuId: skuId, productId: productId, completion: completion)
    }

    private func allSizes(forSKUs skus: [ProductType.SkuType]?) -> [Size] {
        guard let sizes = skus?.flatMap({ $0.size }) else {
            return []
        }

        return sizes
    }

    private func allColors(forSKUs skus: [ProductType.SkuType]?) -> [ProductType.SkuType.ColorType] {
        guard let colors = skus?.flatMap({ $0.color }) else {
            return []
        }

        return colors
    }

    /// Returns all the sizes for the product, available or not.
    ///
    /// - Returns: All the product sizes.
    open func sizes() -> [Size] {
        let allProductSizes = allSizes(forSKUs: product?.skus)
        let uniqueSizes = allProductSizes.uniqueElements()
        return uniqueSizes
    }

    /// Returns all the colors for the product, available or not.
    ///
    /// - Returns: All the product colors.
    open func colors() -> [ProductType.SkuType.ColorType] {
        let allProductColors = allColors(forSKUs: product?.skus)
        let uniqueColors = allProductColors.uniqueElements()
        return uniqueColors
    }

    /// Returns all available sizes for the product.
    ///
    /// - Returns: An array of String sizes.
    open func availableSizes() -> [Size] {
        let availableSizes = allSizes(forSKUs: product?.skus?.filter({ $0.isAvailable }))
        let uniqueAvailableSizes = availableSizes.uniqueElements()
        return uniqueAvailableSizes
    }

    /// Returns all available colors for the product.
    ///
    /// - Returns: An array of ColorType colors.
    open func availableColors() -> [ProductType.SkuType.ColorType] {
        let availableColors = allColors(forSKUs: product?.skus?.filter({ $0.isAvailable }))
        let uniqueAvailableColors = availableColors.uniqueElements()
        return uniqueAvailableColors
    }

    /// Returns all available sizes for a specific product color.
    ///
    /// - Parameter color: The product color.
    /// - Returns: An array of ordered String sizes.
    open func availableSizes(forColor color: ProductType.SkuType.ColorType?) -> [Size] {
        guard let color = color else {
            return availableSizes()
        }

        if let availableSizes = product?.skus?
            .filter({ $0.color?.resourceId == color.resourceId && $0.isAvailable })
            .flatMap({ $0.size }) {
            let uniqueAvailableSizes = availableSizes.uniqueElements()
            return uniqueAvailableSizes
        }

        return []
    }

    /// Returns all available colors for a specific product size.
    ///
    /// - Parameter size: The product size.
    /// - Returns: An array of ColorType colors.
    open func availableColors(forSize size: Size?) -> [ProductType.SkuType.ColorType] {
        guard let size = size else {
            return availableColors()
        }

        if let availableColors = product?.skus?
            .filter({ $0.size == size && $0.isAvailable })
            .flatMap({ $0.color }) {
            let uniqueAvailableColors = availableColors.uniqueElements()
            return uniqueAvailableColors
        }

        return []
    }

    /// Returns a SKU for specific product color and size.
    ///
    /// - Parameters:
    ///   - color: The product color.
    ///   - size: The product size.
    /// - Returns: A SkuType corresponding to the selected color and size.
    /// Returns nil if there is no SKUs matching the color or if the SKU is unavailable.
    open func sku(forColor color: ProductType.SkuType.ColorType?, size: Size?) -> ProductType.SkuType? {
        // If there is only one SKU, it means you can only select a quantity,
        // so don't need to check color and size.
        // NOTE: accessories products are a good example.
        guard let skus = product?.skus else {
            return nil
        }

        if skus.count == 1 {
            return skus.first
        }

        let canSelectColor = availableColors().count > 0
        let canSelectSize = availableSizes().count > 0

        if canSelectColor && canSelectSize {
            return skus.filter({ $0.color?.resourceId == color?.resourceId && $0.size == size }).first
        } else if canSelectColor && !canSelectSize {
            return skus.filter({ $0.color?.resourceId == color?.resourceId }).first
        } else if !canSelectColor && canSelectSize {
            return skus.filter({ $0.size == size }).first
        }

        return nil
    }

    /// Returns an array of all the available quantities for a specific SKU.
    /// If the quantities are integers, the array is ordered lower to higher.
    /// Use this method to build a data source for a picker that you can show
    /// to the user so he can select a quantity based on the SKU.
    ///
    /// - Parameter sku: The selected SKU.
    /// - Returns: An array of quantities.
    open func availableQuantities(forSKU sku: ProductType.SkuType) -> [Int] {
        guard let quantity = sku.availableQuantity else {
            return []
        }

        return availableQuantities(forSKU: sku, limit: quantity)
    }

    /// Returns an array of all the available quantities for a specific SKU.
    /// If the quantities are integers, the array is ordered lower to higher.
    /// Use this method to build a data source for a picker that you can show
    /// to the user so he can select a quantity based on the SKU.
    ///
    /// - Parameters:
    ///   - sku: The selected SkuType.
    ///   - limit: The quantity limit.
    /// - Returns: An array of quantities.
    open func availableQuantities(forSKU sku: ProductType.SkuType, limit: NSInteger) -> [Int] {
        guard let availableQuantity = sku.availableQuantity else {
            return []
        }

        return [Int](1...min(availableQuantity, limit))
    }

    /// Returns a Bool that indicates if the product is out of stock.
    ///
    /// - Returns: true if the product is out of stock. false if not.
    open func isProductOutOfStock() -> Bool {
        guard let skus = product?.skus else {
            return true
        }

        for sku in skus where sku.isAvailable {
            return false
        }

        return true
    }

}
