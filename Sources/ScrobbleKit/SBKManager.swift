//
//  SBKManager.swift
//
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation
#if canImport(Combine)
import Combine
#endif

/// The main class for interacting with the Last.fm API.
public actor SBKManager: Sendable {
    /// The API key for authenticating with Last.fm.
    internal let apiKey: String

    /// The secret key for authenticating with Last.fm.
    internal let secret: String

    #if canImport(Combine)
    /// The session key for authenticated requests. This is set after a successful login.
    @Published public private(set) var sessionKey: String?
    #else
    /// The session key for authenticated requests. This is set after a successful login.
    private var _sessionKey: String?
    /// Returns the current session key if authenticated.
    public var sessionKey: String? { _sessionKey }
    #endif

    /// Creates a new instance of the `SBKManager`.
    ///
    /// - Parameters:
    ///   - apiKey: The API key obtained from Last.fm.
    ///   - secret: The secret key obtained from Last.fm.
    public init(apiKey: String, secret: String) {
        self.apiKey = apiKey
        self.secret = secret
    }

    /// Sets the session key for authenticated requests.
    ///
    /// - Parameter session: The session key to set.
    public func setSessionKey(_ session: String) {
        #if canImport(Combine)
        self.sessionKey = session
        #else
        self._sessionKey = session
        #endif
    }

    /// Starts a new session with Last.fm using the provided credentials.
    ///
    /// - Parameters:
    ///   - username: The Last.fm username.
    ///   - password: The Last.fm password.
    /// - Returns: The session information if successful.
    /// - Throws: An error if the authentication fails.
    @discardableResult
    public func startSession(username: String, password: String) async throws -> SBKSessionResponseInfo {
        let service = AuthSessionService(username: username,
                                         password: password,
                                         apiKey: apiKey,
                                         secretKey: secret)
        let result = try await service.start()
        setSessionKey(result.info.key)
        return result.info
    }

    /// Signs the user out of their Last.fm account.
    ///
    /// This method clears the current session key, effectively ending the user's authenticated session with Last.fm.
    /// After calling this method, any API calls that require authentication will fail until the user signs in again.
    ///
    /// - Note: This method does not perform any network operations. It only clears the local session data.
    public func signOut() {
        #if canImport(Combine)
        self.sessionKey = nil
        #else
        self._sessionKey = nil
        #endif
    }
}

#if canImport(Combine)
extension SBKManager:  ObservableObject {
    
}
#endif
