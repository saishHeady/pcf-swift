//
//  Product.Swift
//  PCF Swift
//
//  Created by Thomas Sivilay on 3/10/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// Size type definition.
public typealias Size = String

/// Product protocol.
public protocol Product {

    associatedtype SkuType: Sku
    associatedtype PersonalizationOptionType: PersonalizationOption
    associatedtype UserReviewType: UserReview
    associatedtype ImageResourceType: ImageResource

    /// Identifier of product.
    var resourceId: String { get }

    /// Name of product.
    var name: String { get }

    /// Product's description. Potentially contains HTML tags.
    var productDescription: String { get }

    /// Full price of the product.
    var price: Float { get }

    /// Sale price of the product.
    var discountedPrice: Float? { get }

    /// Collection of all available SKUs for this product.
    var skus: [SkuType]? { get }

    /// A dictionary of all available images for that product.
    /// Each key represents an ID, and the corresponding value is a
    /// collection of `Image` objects.Should contain images to be displayed
    /// in the main carousel, product variations images.
    var imageResources: [String: [ImageResourceType]]? { get }

    /// Collection of image ids to be displayed in the main carousel.
    /// Those IDs should be ordered in the way they are expected to be presented
    /// to the user and present in `imageResources`. Typically for a PDP the
    /// first image in the array will show up first.
    var imageIds: [String] { get }

    /// Collection of category ids.
    var categoryIds: [String]? { get }

    /// Collection of wishlist ids.
    var wishlistIds: [String]? { get }

    /// Collection of all available personalization options for this product.
    var personalizationOptions: [PersonalizationOptionType]? { get }

    /// Contains summary information of user reviews.
    var userReviews: UserReviewType? { get }

    /// Collection of image ids (see imageResources key) to be used for reviews previews.
    var userImageIds: [String]? { get }

    /// Collection of tags associated to the product.
    var tags: [String]? { get }

    /// Convenience method to return all the image URLs for a specific usage.
    ///
    /// - Parameter usage: A kPCFImageUsage constant.
    /// - Returns: An array of URLs for the given usage.
    func imageURLs(usage: String) -> [URL]

    /// Convenience method to return the image URL for an imageId with a specific usage
    ///
    /// - Parameters:
    ///   - imageId: A valid imageId.
    ///   - usage: A kPCFImageUsage constant.
    /// - Returns: An URL for the image with the given usage.
    func imageURL(withImageId imageId: String, usage: String) -> URL?

}

public extension Product {

    public func imageURLs(usage: String) -> [URL] {
        var urls: [URL] = []

        if let sortedKeys = self.imageResources?.keys.sorted() {
            for key in sortedKeys {
                if let imageURLs = self.imageResources?[key]?.filter({ $0.usage == usage }).map({ $0.url }) {
                    urls.append(contentsOf: imageURLs)
                }
            }
        }

        return urls
    }

    public func imageURL(withImageId imageId: String, usage: String) -> URL? {
        let resource = imageResources?[imageId]

        guard let imageResource = resource else {
            return nil
        }

        for pcfDictionary in imageResource {
            let currentUsage = pcfDictionary.usage
            let pcfUrl = pcfDictionary.url

            if currentUsage == usage {
                return pcfUrl as URL
            }
        }

        return nil
    }

}
