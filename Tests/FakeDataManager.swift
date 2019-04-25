//
//  FakeDataManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 4/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

@testable import PCFSwift

struct FakeGloss {

    struct DecodableObject: Swift.Decodable {
        init() { }
    }

}

class FakeDataManager: DataManager {

    public let environmentManager: HTTPEnvironmentManager
    public let httpClient: HTTPClient
    public let sessionManager: SessionManager
    var decoder: JSONDecoder

    private var shouldAttemptRequest = true

    public init(environmentManager: HTTPEnvironmentManager,
                sessionManager: SessionManager,
                httpClient: HTTPClient,
                decoder: JSONDecoder = JSONDecoder()) {
        self.environmentManager = environmentManager
        self.sessionManager = sessionManager
        self.httpClient = httpClient
        self.decoder = decoder
    }

    func perform<T: Swift.Decodable>(request: HTTPRequest, completion: @escaping (T?, Swift.Error?) -> Void) {
        if shouldAttemptRequest {
            shouldAttemptRequest = false
            sessionManager.resetSession(request: request) { (response, _) in
                if let data = response?.data as? Data {
                    do {
                        let model = try self.decoder.decode(T.self, from: data)
                        completion(model, nil)
                    } catch {
                        completion(nil, error)
                    }
                } else {
                    completion(nil, PCFError.invalidJSON)
                }
            }
        } else {
            completion(nil, nil)
        }
    }

    func perform<T: Swift.Decodable>(request: HTTPRequest, completion: @escaping ([T], Swift.Error?) -> Void) {
        if shouldAttemptRequest {
            shouldAttemptRequest = false
            sessionManager.resetSession(request: request) { (response, _) in
                if let data = response?.data as? Data {
                    do {
                        let models = try self.decoder.decode([T].self, from: data)
                        completion(models, nil)
                    } catch {
                        completion([], error)
                    }
                } else {
                    completion([], PCFError.invalidJSON)
                }
            }
        } else {
            completion([], nil)
        }
    }

}
