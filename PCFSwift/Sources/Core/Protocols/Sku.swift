//
//  Sku.Swift
//  PCF Swift
//
//  Created by Thomas Sivilay on 3/10/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 *  Sku protocol
 */
public protocol Sku {

    associatedtype ColorType: Color

    /// Unique identifier for the SKU.
    var resourceId: String { get }

    /// Indicates if a SKU is available or not. Needed in case
    /// availableQuantity can't be determined but is for sure > 0.
    var isAvailable: Bool { get }

    /// Number of items available for this SKU.
    var availableQuantity: Int? { get }

    /// Price for this SKU, prices could vary between SKUs, overrides product price.
    var price: Float { get }

    /// Discounted price of the SKU, overrides product `discountedPrice.
    var discountedPrice: Float? { get }

    /// Collection of images IDs for that SKU. IDs referenced here
    /// must be listed in the imageResources dictionary that comes
    // along with the product.
    var imageIds: [String] { get }

    /// Contains color information.
    var color: ColorType? { get }

    /// SKU Size
    var size: String? { get }

    /// SKU Style
    var style: String? { get }

}
