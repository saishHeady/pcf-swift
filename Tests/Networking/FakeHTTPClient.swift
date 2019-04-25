//
//  FakeHTTPClient.swift
//  PCFSwift
//
//  Created by Thibault Klein on 2/19/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import PCFSwift

struct FakeHTTPClient: HTTPClient {

    private let jsonName: String

    init() {
        self.init(jsonName: "")
    }

    init(jsonName: String) {
        self.jsonName = jsonName
    }

    func perform(request: HTTPRequest,
                 completion: @escaping (_ response: HTTPResponse?, _ error: Swift.Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            do {
                let data = try TestServer.getJSONData(self.jsonName)
                let httpResponse = HTTPResponse(data: data, statusCode: 200)
                completion(httpResponse, nil)
            } catch {
                let error = PCFError(code: 1, message: "The JSON could not be opened")
                completion(nil, error)
            }
        }
    }

}
