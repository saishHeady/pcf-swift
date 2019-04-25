//
//  AlamofireHTTPMethod.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/28/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Alamofire

public extension HTTPMethod {

    /// Alamofire HTTP method.
    var alamofireMethod: Alamofire.HTTPMethod {
        switch self {
        case .get: return Alamofire.HTTPMethod.get
        case .post: return Alamofire.HTTPMethod.post
        case .delete: return Alamofire.HTTPMethod.delete
        case .put: return Alamofire.HTTPMethod.put
        case .patch: return Alamofire.HTTPMethod.patch
        }
    }

}
