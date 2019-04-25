//
//  AddToCartPersonalizationsParameters.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Data transfer object to add a personalization option to a cart item for add to cart HTTP request.
public struct AddToCartPersonalizationsParameters: ParameterConvertible {

    /// The personalization option id.
    let resourceId: String

    /// The personalization option label.
    let label: String

    /// The personalization option selected value.
    let selectedValue: String

    /// Default initializer for an add to cart personalization option data transfer object.
    ///
    /// - Parameters:
    ///   - resourceId: The resource id to use.
    ///   - label: The label to use.
    ///   - selectedValue: The selected value to use.
    public init(resourceId: String, label: String, selectedValue: String) {
        self.resourceId = resourceId
        self.label = label
        self.selectedValue = selectedValue
    }

    public func toParameters() -> Parameters {
        return [
            "id": resourceId,
            "label": label,
            "selectedValue": selectedValue
        ]
    }

}
