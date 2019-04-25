//
//  PCFPersonalizationOption.Swift
//  PCF Swift
//
//  Created by Thomas Sivilay on 3/10/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 *  PCFPersonalizationOption model
 */
public struct PCFPersonalizationOption: PersonalizationOption, Swift.Decodable {

    /// Identifier of product.
    public let resourceId: String

    /// The type of the personalization field.
    public let label: String

    /// The type of the personalization field.
    public let type: String

    /// Array containing the possible values for this field. Only set when
    /// `type` == 'options'.
    public let options: [String]?

    /// Link to an image for instructions, not all fields have this.
    public let instructionsURL: String?

    /// Value that has been selected for that field. Will **always**
    /// be null in the product object, and not null in the cart.
    public let selectedValue: String?

}

// MARK: - Swift.Decodable

public extension PCFPersonalizationOption {

    private enum PersonalizationOptionCodingKeys: String, CodingKey {
        case resourceId = "id"
        case label
        case type
        case options
        case instructionsURL = "instructionsUrl"
        case selectedValue
    }

    public init(from decoder: Swift.Decoder) throws {
        let personalizationOptionContainer = try decoder.container(keyedBy: PersonalizationOptionCodingKeys.self)

        resourceId = try personalizationOptionContainer.decode(String.self, forKey: .resourceId)
        label = try personalizationOptionContainer.decode(String.self, forKey: .label)
        type = try personalizationOptionContainer.decode(String.self, forKey: .type)
        options = try personalizationOptionContainer.decodeIfPresent([String].self, forKey: .options)
        instructionsURL = try personalizationOptionContainer.decodeIfPresent(String.self, forKey: .instructionsURL)
        selectedValue = try personalizationOptionContainer.decodeIfPresent(String.self, forKey: .selectedValue)

    }

}
