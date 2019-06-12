//
//  HTTPClient+Alamofire.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/28/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Alamofire

public extension HTTPClient {
    
    func validStatusCodes() -> [Int] {
        var codes: [Int] = Array(200..<300)
        // Need to add 403 status code to allow PerimeterX Bot detector to block illegitimate request
        codes.append(403)
        return codes
    }

    public func perform(request: HTTPRequest,
                        completion: @escaping (_ response: HTTPResponse?, _ error: Swift.Error?) -> Void) {
        Alamofire.request(request.endpoint,
                          method: request.method.alamofireMethod,
                          parameters: request.parameters,
                          encoding: JSONEncoding.default,
                          headers: request.headers)
            .validate(statusCode: validStatusCodes())
            .responseJSON { (response: DataResponse<Any>) in
                
                #if DEBUG
                if let envData = getenv("NETWORK_LOG_ENABLE"),
                    let networkLogUTF8String = String(utf8String: envData),
                    let isNetworkLogEnabled = Bool(networkLogUTF8String) {
                    if isNetworkLogEnabled {
                        self.debugLog(request: request, response: response)
                    }
                } else {
                    self.debugLog(request: request, response: response)
                }
                #endif
                
                if response.result.isSuccess {
                    self.handleSuccessfulResponse(response, completion: completion)
                } else {
                    self.handleUnsuccessfulResponse(response, completion: completion)
                }
        }
    }
    
    private func debugLog(request: HTTPRequest, response: DataResponse<Any>) {
        print("------------------------------------------------------------------")
        if let headers = request.headers {
            print("[Headers]: ")
            dump(headers)
        }
        print("[Parameter]: ")
        dump(request.parameters ?? [:])
        
        debugPrint(response)
        print("------------------------------------------------------------------")
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
