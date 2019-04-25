//
//  DataManager.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 3/16/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// The base protocol for all data managers. Contains functionality common to all data managers.
public protocol DataManager {

    /// The HTTP environment manager used for determining the appropriate environment when communicating
    /// with the API.
    var environmentManager: HTTPEnvironmentManager { get }

    /// The HTTP client used for communication with the API.
    var httpClient: HTTPClient { get }

    /// The Session Manager used for handling session id for the app
    var sessionManager: SessionManager { get }

    /// The JSON Decoder used to perform JSON Decoding of underlying models
    var decoder: JSONDecoder { get }

    /// Returns the headers to be passed through the HTTP request for the specified environment
    ///
    /// - Parameter environment: The specific HTTPEnvironment under consideration
    /// - Returns: Headers for the current environment
    func headers(forEnvironment environment: HTTPEnvironment) -> Headers

}

extension DataManager {

    public func headers(forEnvironment environment: HTTPEnvironment) -> Headers {
        return environment.defaultHTTPHeaders.combineWith(sessionManager.sessionHeaders)
    }

    /// Performs the given HTTP request for returning a single object.
    ///
    /// - Parameters:
    ///   - request: The request to perform.
    ///   - completion: The completion block.
    public func perform<T: Swift.Decodable>(request: HTTPRequest, completion: @escaping (T?, Swift.Error?) -> Void) {
        if sessionManager.isSessionExpired() {
            sessionManager.resetSession(request: request) { response, error in
                self.decodeResponse((response, error), completion: completion)
            }
        } else {
            httpClient.perform(request: request) { (response, error) in
                if let error = error {
                    if self.sessionManager.isSessionError(error: error) {
                        self.sessionManager.resetSession(request: request) { response, error in
                            self.decodeResponse((response, error), completion: completion)
                        }
                    } else {
                        completion(nil, error)
                    }
                } else {
                    self.decodeData(response?.data, completion: completion)
                }
            }
        }
    }

    /// Performs the given HTTP request for returning an array of objects.
    ///
    /// - Parameters:
    ///   - request: The request to perform.
    ///   - completion: The completion block.
    public func perform<T: Swift.Decodable>(request: HTTPRequest, completion: @escaping ([T], Swift.Error?) -> Void) {
        if sessionManager.isSessionExpired() {
            sessionManager.resetSession(request: request) { response, error in
                self.decodeResponse((response, error), completion: completion)
            }
        } else {
            httpClient.perform(request: request) { (response, error) in
                if let error = error {
                    if self.sessionManager.isSessionError(error: error) {
                        self.sessionManager.resetSession(request: request) { response, error in
                            self.decodeResponse((response, error), completion: completion)
                        }
                    } else {
                        completion([], error)
                    }
                } else {
                    self.decodeDataArray(response?.data, completion: completion)
                }
            }
        }
    }

    private func decodeResponse<T: Swift.Decodable>(_ response: (details: HTTPResponse?, error: Swift.Error?),
                                                    completion: @escaping (T?, Swift.Error?) -> Void) {
        if let error = response.error {
            completion(nil, error)
        } else {
            decodeData(response.details?.data, completion: completion)
        }
    }

    private func decodeResponse<T: Swift.Decodable>(_ response: (details: HTTPResponse?, error: Swift.Error?),
                                                    completion: @escaping ([T], Swift.Error?) -> Void) {
        if let error = response.error {
            completion([], error)
        } else {
            decodeDataArray(response.details?.data, completion: completion)
        }
    }

    private func decodeData<T: Swift.Decodable>(_ data: Any?, completion: @escaping (T?, Swift.Error?) -> Void) {
        guard let data = data as? Data else {
            completion(nil, PCFError.invalidJSON)
            return
        }

        do {
            let model = try decoder.decode(T.self, from: data)
            completion(model, nil)
        } catch {
            completion(nil, PCFError.invalidJSON)
        }
    }

    private func decodeDataArray<T: Swift.Decodable>(_ data: Any?, completion: @escaping ([T], Swift.Error?) -> Void) {
        guard let data = data as? Data else {
            completion([], PCFError.invalidJSON)
            return
        }

        do {
            let model = try decoder.decode([T].self, from: data)
            completion(model, nil)
        } catch {
            completion([], PCFError.invalidJSON)
        }
    }

}
