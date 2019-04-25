//
//  PCFProduct.Swift
//  PCF Swift
//
//  Created by Thomas Sivilay on 3/10/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 *  PCFProduct model
 */
public struct PCFProduct: Product, Swift.Decodable {

    public typealias SkuType = PCFSku
    public typealias PersonalizationOptionType = PCFPersonalizationOption
    public typealias UserReviewType = PCFUserReview
    public typealias ColorType = PCFColor
    public typealias ImageResourceType = PCFImageResource

    /// Identifier of product.
    public let resourceId: String

    /// Name of product.
    public let name: String

    /// Full price of the product.
    public let price: Float

    /// Sale price of the product.
    public let discountedPrice: Float?

    /// Product's description. Potentially contains HTML tags.
    public let productDescription: String

    /// A dictionary of all available images for that product.
    /// Each key represents an ID, and the corresponding value is a
    /// collection of `Image` objects.Should contain images to be displayed
    /// in the main carousel, product variations images.
    public let imageResources: [String: [ImageResourceType]]?

    /// Collection of image ids to be displayed in the main carousel.
    /// Those IDs should be ordered in the way they are expected to be presented
    /// to the user and present in `imageResources`. Typically for a PDP the
    /// first image in the array will show up first.
    public let imageIds: [String]

    /// Collection of category ids.
    public let categoryIds: [String]?

    /// Collection of wishlist ids.
    public let wishlistIds: [String]?

    /// Collection of all available SKUs for this product.
    public let skus: [SkuType]?

    /// Collection of all available personalization options for this product.
    public let personalizationOptions: [PersonalizationOptionType]?

    /// Contains summary information of user reviews.
    public let userReviews: UserReviewType?

    /// Collection of image ids (see imageResources key) to be used for reviews previews.
    public let userImageIds: [String]?

    /// Collection of tags associated to the product.
    public let tags: [String]?

}

// MARK: - Swift.Decodable

public extension PCFProduct {

    private enum ProductCodingKeys: String, CodingKey {
        case resourceId = "id"
        case name
        case price
        case productDescription = "description"
        case discountedPrice
        case imageResources
        case imageIds
        case categoryIds
        case wishlistIds
        case skus
        case personalizationOptions
        case userReviews
        case userImageIds
        case tags
    }

    public init(from decoder: Swift.Decoder) throws {
        let productContainer = try decoder.container(keyedBy: ProductCodingKeys.self)

        resourceId = try productContainer.decode(String.self, forKey: .resourceId)
        name = try productContainer.decode(String.self, forKey: .name)
        price = try productContainer.decode(Float.self, forKey: .price)
        productDescription = try productContainer.decode(String.self, forKey: .productDescription)
        discountedPrice = try productContainer.decodeIfPresent(Float.self, forKey: .discountedPrice)
        imageResources = try productContainer.decodeIfPresent([String: [ImageResourceType]].self, forKey: .imageResources)
        imageIds = try productContainer.decode([String].self, forKey: .imageIds)
        categoryIds = try productContainer.decodeIfPresent([String].self, forKey: .categoryIds)
        wishlistIds = try productContainer.decodeIfPresent([String].self, forKey: .wishlistIds)
        skus = try productContainer.decodeIfPresent([SkuType].self, forKey: .skus)
        personalizationOptions = try productContainer.decodeIfPresent([PersonalizationOptionType].self, forKey: .personalizationOptions)
        userReviews = try productContainer.decodeIfPresent(UserReviewType.self, forKey: .userReviews)
        userImageIds = try productContainer.decodeIfPresent([String].self, forKey: .userImageIds)
        tags = try productContainer.decodeIfPresent([String].self, forKey: .tags)

    }

}
