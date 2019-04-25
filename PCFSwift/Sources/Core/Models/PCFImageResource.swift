//
//  PCFImageResource.Swift
//  PCF Swift
//
//  Created by Thomas Sivilay on 3/10/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 *  PCFImageResource model
 */
public struct PCFImageResource: ImageResource, Swift.Decodable {

    /// Full URL to download the image.
    public let url: URL

    /// Represents the context in which the image should be used.
    public let usage: String

}
