//
//  ImageResource.Swift
//  PCF Swift
//
//  Created by Thomas Sivilay on 3/10/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 *  ImageResource protocol
 */
public protocol ImageResource {

    /// Image resource URL.
    var url: URL { get }

    /// Image resource usage.
    var usage: String { get }

}
