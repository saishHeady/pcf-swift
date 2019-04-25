//
//  Array+ImageResource.swift
//  PCFSwift
//
//  Created by Thibault Klein on 7/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

extension Array where Element: ImageResource {

    /**
     Returns the URL associated with the given image usage.

     - parameter usage: The usage required.

     - returns: The URL associated with the usage.
     */
    func imageURL(_ usage: String) -> URL? {
        return self.filter { $0.usage == usage }.first?.url
    }

}
