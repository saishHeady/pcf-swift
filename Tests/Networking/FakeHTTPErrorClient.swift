//
//  FakeHTTPErrorClient.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import PCFSwift

struct FakeHTTPErrorClient: HTTPClient {

    private let jsonName: String

    init(jsonName: String) {
        self.jsonName = jsonName
    }

    func perform(request: HTTPRequest,
                 completion: @escaping (_ response: Any?, _ error: Swift.Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            do {
                let errorJSONData = try TestServer.getJSONData(self.jsonName)
                let error = try JSONDecoder().decode(PCFError.self, from: errorJSONData)
                completion(nil, error)
            } catch {
                fatalError("Fake HTTP Error client failed to create an error")
            }
        }
    }

}
