//
//  PCFColor.Swift
//  PCF Swift
//
//  Created by Thomas Sivilay on 3/10/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/**
 *  PCFColor model
 */
public struct PCFColor: Color, Swift.Decodable {

    public typealias ImageResourceType = PCFImageResource

    /// The hex value of the color.
    public let resourceId: String

    /// The id of the color.
    public let label: String

    /// For pattern style colors that can\'t be defined with a hex code (e.g. plaid, stripes)
    public let hex: String?

    /// The display name of the color.
    public let imagePattern: ImageResourceType?

    public init(resourceId: String,
                label: String,
                hex: String?,
                imagePattern: ImageResourceType?) {
        self.resourceId = resourceId
        self.label = label
        self.hex = hex
        self.imagePattern = imagePattern
    }

}

// MARK: - Swift.Decodable

public extension PCFColor {

    private enum ColorCodingKeys: String, CodingKey {
        case resourceId = "id"
        case label
        case hex
        case imagePattern
    }

    public init(from decoder: Swift.Decoder) throws {
        let colorContainer = try decoder.container(keyedBy: ColorCodingKeys.self)

        resourceId = try colorContainer.decode(String.self, forKey: .resourceId)
        label = try colorContainer.decode(String.self, forKey: .label)
        hex = try colorContainer.decodeIfPresent(String.self, forKey: .hex)
        imagePattern = try colorContainer.decodeIfPresent(ImageResourceType.self, forKey: .imagePattern)
    }

}
