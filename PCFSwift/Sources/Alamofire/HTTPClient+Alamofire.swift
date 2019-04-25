//
//  HTTPClient+Alamofire.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/28/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Alamofire

public extension HTTPClient {

    public func perform(request: HTTPRequest,
                        completion: @escaping (_ response: HTTPResponse?, _ error: Swift.Error?) -> Void) {
        Alamofire.request(request.endpoint,
                          method: request.method.alamofireMethod,
                          parameters: request.parameters,
                          encoding: JSONEncoding.default,
                          headers: request.headers)
            .validate()
            .debugLog()
            .responseJSON { (response: DataResponse<Any>) in
                if response.result.isSuccess {
                    self.handleSuccessfulResponse(response, completion: completion)
                } else {
                    self.handleUnsuccessfulResponse(response, completion: completion)
                }
        }
    }

    private func handleSuccessfulResponse(_ response: DataResponse<Any>,
                                          completion: @escaping (HTTPResponse?, Swift.Error?) -> Void) {
        let httpResponse = HTTPResponse(data: response.data,
                                        statusCode: response.response?.statusCode)
        completion(httpResponse, response.error)
    }

    private func handleUnsuccessfulResponse(_ response: DataResponse<Any>,
                                            completion: @escaping (HTTPResponse?, Swift.Error?) -> Void) {
        if let responseData = response.data {
            completion(nil, try? JSONDecoder().decode(PCFError.self, from: responseData))
        } else {
            let httpResponse = HTTPResponse(data: response.data,
                                            statusCode: response.response?.statusCode)
            completion(httpResponse, response.error)
        }
    }

}

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint(self)
        #endif
        return self
    }
}
