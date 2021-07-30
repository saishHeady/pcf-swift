//
//  PCFUserReview.Swift
//  PCF Swift
//
//  Created by Thomas Sivilay on 3/10/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// PCFUserReview model
public struct PCFUserReview: UserReview, Swift.Decodable {

    /// The number of reviews.
    public let reviewCount: Int?

    /// The overall rating.
    public let overallRating: Float?

    ///  The max rating.
    public let maxRating: Float?

}

// MARK: Swift.Decodable

public extension PCFUserReview {

    private enum UserReviewCodingKeys: String, CodingKey {
        case reviewCount = "userReviewsCount"
        case overallRating = "overallRating"
        case maxRating = "maxRating"
    }

    init(from decoder: Swift.Decoder) throws {
        let userReviewContainer = try decoder.container(keyedBy: UserReviewCodingKeys.self)

        reviewCount = try userReviewContainer.decodeIfPresent(Int.self, forKey: .reviewCount)
        overallRating = try userReviewContainer.decodeIfPresent(Float.self, forKey: .overallRating)
        maxRating = try userReviewContainer.decodeIfPresent(Float.self, forKey: .maxRating)
    }

}
