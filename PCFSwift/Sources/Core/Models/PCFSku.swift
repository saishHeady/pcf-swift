//
//  PCFSku.Swift
//  PCF Swift
//
//  Created by Thomas Sivilay on 3/10/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 *  PCFSku model
 */
public struct PCFSku: Sku, Swift.Decodable {

    public typealias ColorType = PCFColor

    /// Unique identifier for the SKU.
    public let resourceId: String

    /// Indicates if a SKU is available or not. Needed in case
    /// availableQuantity can't be determined but is for sure > 0.
    public let isAvailable: Bool

    /// Number of items available for this SKU.
    public let availableQuantity: Int?

    /// Price for this SKU, prices could vary between SKUs, overrides product price.
    public let price: Float

    /// Discounted price of the SKU, overrides product `discountedPrice.
    public let discountedPrice: Float?

    /// Collection of images IDs for that SKU. IDs referenced here
    /// must be listed in the imageResources dictionary that comes
    // along with the product.
    public let imageIds: [String]

    /// Contains color information.
    public let color: ColorType?

    /// SKU Size
    public let size: String?

    /// SKU Style
    public let style: String?

}

// MARK: - Swift.Decodable

public extension PCFSku {

    private enum SkuCodingKeys: String, CodingKey {
        case resourceId = "id"
        case isAvailable
        case availableQuantity
        case price
        case discountedPrice
        case imageIds
        case color
        case size
        case style
    }

    public init(from decoder: Swift.Decoder) throws {
        let skuContainer = try decoder.container(keyedBy: SkuCodingKeys.self)

        resourceId = try skuContainer.decode(String.self, forKey: .resourceId)
        isAvailable = try skuContainer.decode(Bool.self, forKey: .isAvailable)
        availableQuantity = try skuContainer.decodeIfPresent(Int.self, forKey: .availableQuantity)
        price = try skuContainer.decode(Float.self, forKey: .price)
        discountedPrice = try skuContainer.decodeIfPresent(Float.self, forKey: .discountedPrice)
        imageIds = try skuContainer.decode([String].self, forKey: .imageIds)
        color = try skuContainer.decodeIfPresent(ColorType.self, forKey: .color)
        size = try skuContainer.decodeIfPresent(String.self, forKey: .size)
        style = try skuContainer.decodeIfPresent(String.self, forKey: .style)
    }

}
