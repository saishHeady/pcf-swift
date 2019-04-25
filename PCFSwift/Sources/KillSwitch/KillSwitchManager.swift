//
//  KillSwitchManager.swift
//  PCFSwift
//
//  Created by Thibault Klein on 5/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Bellerophon
import Siren

/// Kill Switch manager.
public class KillSwitchManager: BellerophonManagerDelegate {

    /// HTTP client.
    let httpClient: HTTPClient

    /// HTTP request.
    let httpRequest: HTTPRequest

    /// The kill switch manager from the SDK.
    let killSwitch: BellerophonManager

    let errorHandler: (NSError) -> Void

    /// Initializes the kill switch manager.
    ///
    /// - Parameters:
    ///   - httpClient: The HTTP client to use in order to check the app status.
    ///   - httpRequest: The HTTP request to perform in order to check the app status.
    ///   - window: The window to display the kill switch UI from.
    ///   - killSwitchView: The view to present in case the kill switch is active.
    public init(httpClient: HTTPClient,
                httpRequest: HTTPRequest,
                window: UIWindow,
                killSwitchView: UIView,
                errorHandler: @escaping (NSError) -> Void) {
        self.httpClient = httpClient
        self.httpRequest = httpRequest
        self.errorHandler = errorHandler

        killSwitch = BellerophonManager(window: window)
        killSwitch.delegate = self
        killSwitch.killSwitchView = killSwitchView
    }

    /// Check the current app status. Will detect if the app is inactive or needs to update.
    public func checkAppStatus() {
        killSwitch.checkAppStatus()
    }

    /// Use this function to retrieve and handle app status when the app has background mode enabled.
    ///
    /// - Parameter completionHandler: The background fetch completion handler.
    public func fetchAppStatus(_ completionHandler: @escaping (_ result: UIBackgroundFetchResult) -> Void) {
        killSwitch.fetchAppStatus(completionHandler)
    }

    // MARK: - BellerophonManagerDelegate Functions

    public func bellerophonStatus(_ manager: BellerophonManager,
                                  completion: @escaping (_ status: BellerophonObservable?, _ error: NSError?) -> Void) {
        httpClient.perform(request: httpRequest) { (response, error) in
            if let error = error as NSError? {
                completion(nil, error)
            } else {
                guard let data = response?.data as? Data else {
                    completion(nil, PCFError.invalidJSON as NSError)
                    return
                }
                do {
                    let model = try JSONDecoder().decode(KillSwitchModel.self, from: data)
                    completion(model, nil)
                    return
                } catch {
                    completion(nil, error as NSError)
                    return
                }
            }
        }
    }

    public func shouldForceUpdate() {
        let siren = Siren.shared
        siren.alertType = .force
        siren.checkVersion(checkType: .immediately)
    }

    public func receivedError(error: NSError) {
        errorHandler(error)
    }

}
