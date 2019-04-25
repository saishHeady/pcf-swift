//
//  PCFSessionManager.swift
//  Pods
//
//  Created by Sagar Natekar on 3/14/17.
//
//

/// Default Session manager for PCF
open class PCFSessionManager: SessionManager {

    public let environmentManager: HTTPEnvironmentManager
    public let httpClient: HTTPClient
    public let persistenceClient: Persistable?

    private var sessionIdKey: String {
        return "sessionId"
    }

    public init(environmentManager: HTTPEnvironmentManager,
                httpClient: HTTPClient,
                persistenceClient: Persistable? = nil) {
        self.environmentManager = environmentManager
        self.httpClient = httpClient
        self.persistenceClient = persistenceClient
    }

    open func isSessionExpired() -> Bool {
        return false
    }

    open var sessionHeaders: Headers {
        return [sessionIdKey: persistenceClient?.object(forKey: sessionIdKey) as? String ?? ""]
    }

    open func retrieveSessionIdentifier(completion: @escaping (_ error: Swift.Error?) -> Void) {
        let path = "/sessions"
        let request = HTTPRequest(method: .get,
                                  baseURL: environmentManager.currentEnvironment.baseURL,
                                  path: path,
                                  queryItems: nil,
                                  parameters: nil,
                                  headers: environmentManager.currentEnvironment.defaultHTTPHeaders)
        perform(request: request) { (sessionIdentifier, error) in
            self.persistenceClient?.set(sessionIdentifier, forKey: self.sessionIdKey)
            completion(error)
        }
    }

    private func perform(request: HTTPRequest,
                         completion: @escaping (_ sessionId: String?, _ error: Swift.Error?) -> Void) {
        httpClient.perform(request: request) { (response, error) in
            if let error = error {
                completion(nil, PCFError(code: 1, message: error.localizedDescription))
            } else if
                let data = response?.data as? Data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSON {
                completion(json?[self.sessionIdKey] as? String, nil)
            } else {
                completion(nil, PCFError.invalidJSON)
            }
        }
    }

}
