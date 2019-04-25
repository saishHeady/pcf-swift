//
//  SequenceExtension.swift
//  PCFSwift
//
//  Created by Thibault Klein on 6/2/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

extension Sequence where Iterator.Element: Equatable {

    /// Returns all the unique elements of the sequence.
    ///
    /// - Returns: The sequence with only unique elements.
    func uniqueElements() -> [Iterator.Element] {
        return self.reduce([], { (uniqueElements, element) in
            if uniqueElements.contains(element) {
                return uniqueElements
            }

            return uniqueElements + [element]
        })
    }

}
