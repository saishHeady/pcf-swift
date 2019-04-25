//
//  UserReview.Swift
//  PCF Swift
//
//  Created by Thomas Sivilay on 3/10/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// UserReview protocol
public protocol UserReview {

    /// The number of reviews.
    var reviewCount: Int? { get }

    /// The overall rating.
    var overallRating: Float? { get }

    ///  The max rating.
    var maxRating: Float? { get }

}
