//
//  SessionManager.swift
//  PCFSwift
//
//  Created by Sagar Natekar on 3/14/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

/// Session Manager protocol
public protocol SessionManager {

    /// The HTTP environment manager used for determining the appropriate environment when communicating
    /// with the API.
    var environmentManager: HTTPEnvironmentManager { get }

    /// The HTTP client used for communication with the API.
    var httpClient: HTTPClient { get }

    /// The persistence client that can save and retrieve values from disk based on a String key
    var persistenceClient: Persistable? { get }

    /// Headers that need to be sent with HTTP requests during a session.
    var sessionHeaders: Headers { get }

    /// Whether the provided error is a PCF session error.
    ///
    /// - Parameter error: Error.
    /// - Returns: True if the error is a PCF session error, false otherwise.
    func isSessionError(error: Swift.Error) -> Bool

    /// Whether the current session is expired.
    ///
    /// - Returns: True if the current session is expired, false otherwise.
    func isSessionExpired() -> Bool

    /// Retrieves a new session identifier from the endpoint.
    ///
    /// - Parameter completion: Completion block that is called upon receiving the response with either
    ///                         the session identifier or an error.
    func retrieveSessionIdentifier(completion: @escaping (_ error: Swift.Error?) -> Void)

    /// Resets the user's session and performs the call initiated before receiving an error related with the session.
    ///
    /// - Parameters:
    ///   - request: The request to perform after the session is reset.
    ///   - completion: The completion block with the data returned from the original request.
    func resetSession(request: HTTPRequest, completion: @escaping (HTTPResponse?, Swift.Error?) -> Void)

}

extension SessionManager {

    public func isSessionError(error: Swift.Error) -> Bool {
        guard let error = error as? PCFSwift.Error else {
            return false
        }

        return error.isSessionError()
    }

    public func resetSession(request: HTTPRequest,
                             completion: @escaping (_ response: HTTPResponse?, Swift.Error?) -> Void) {
        retrieveSessionIdentifier { (error) in
            if error == nil {
                self.httpClient.perform(request: request) { (response, error) in
                    if let error = error {
                        completion(nil, error)
                    } else {
                        guard let response = response else {
                            completion(nil, PCFError.invalidJSON)
                            return
                        }

                        completion(response, nil)
                    }
                }
            } else {
                completion(nil, error)
            }
        }
    }

}
