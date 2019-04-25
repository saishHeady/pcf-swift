//
//  PersonalizationOptions.Swift
//  PCF Swift
//
//  Created by Thomas Sivilay on 3/10/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 *  PersonalizationOption protocol
 */
public protocol PersonalizationOption {

    /// Identifier of product.
    var resourceId: String { get }

    /// The type of the personalization field.
    var label: String { get }

    /// The type of the personalization field.
    var type: String { get }

    /// Array containing the possible values for this field. Only set when
    /// `type` == 'options'.
    var options: [String]? { get }

    /// Link to an image for instructions, not all fields have this.
    var instructionsURL: String? { get }

    /// Value that has been selected for that field. Will **always**
    /// be null in the product object, and not null in the cart.
    var selectedValue: String? { get }
}
