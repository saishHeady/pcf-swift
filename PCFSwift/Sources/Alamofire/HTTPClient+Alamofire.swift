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

    func perform(request: HTTPRequest,
                 completion: @escaping (_ response: HTTPResponse?, _ error: Swift.Error?) -> Void) {
        
        AF.request(request.endpoint,
                   method: request.method.alamofireMethod,
                   parameters: request.parameters,
                   encoding: JSONEncoding.default,
                   headers: HTTPHeaders(request.headers ?? [:]),
                   interceptor: nil)
            .validate(statusCode: validStatusCodes())
            .responseJSON { (response: AFDataResponse<Any>) in
                
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
                
                switch response.result {
                case .success:
                    self.handleSuccessfulResponse(response, completion: completion)
                case .failure:
                    self.handleUnsuccessfulResponse(response, completion: completion)
                }
        }
        
    }
    
    private func debugLog(request: HTTPRequest, response: AFDataResponse<Any>) {
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

    private func handleSuccessfulResponse(_ response:  AFDataResponse<Any>,
                                          completion: @escaping (HTTPResponse?, Swift.Error?) -> Void) {
        
        let httpResponse = HTTPResponse(data: response.data as Any,
                                        statusCode: response.response?.statusCode)
        completion(httpResponse, response.error)
    }

    private func handleUnsuccessfulResponse(_ response: AFDataResponse<Any>,
                                            completion: @escaping (HTTPResponse?, Swift.Error?) -> Void) {
        if let responseData = response.data {
            completion(nil, try? JSONDecoder().decode(PCFError.self, from: responseData))
        } else {
            let httpResponse = HTTPResponse(data: response.data as Any,
                                            statusCode: response.response?.statusCode)
            completion(httpResponse, response.error)
        }
    }

}
