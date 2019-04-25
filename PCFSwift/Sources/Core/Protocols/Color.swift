//
//  Color.Swift
//  PCF Swift
//
//  Created by Thomas Sivilay on 3/10/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 *  Color protocol
 */
public protocol Color: Equatable {

    associatedtype ImageResourceType: ImageResource

    /// The hex value of the color.
    var resourceId: String { get }

    /// The id of the color.
    var label: String { get }

    /// For pattern style colors that can\'t be defined with a hex code (e.g. plaid, stripes)
    var hex: String? { get }

    /// The display name of the color.
    var imagePattern: ImageResourceType? { get }

}

public func ==<T: Color>(lhs: T, rhs: T) -> Bool {
    return lhs.resourceId == rhs.resourceId && lhs.label == rhs.label
}
