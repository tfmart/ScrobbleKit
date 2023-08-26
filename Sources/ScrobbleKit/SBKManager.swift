//
//  SBKManager.swift
//
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation
import Combine

public class SBKManager: ObservableObject {
    internal let apiKey: String
    internal let secret: String
    internal var sessionKey: String?
    
    public init(apiKey: String, secret: String) {
        self.apiKey = apiKey
        self.secret = secret
    }
    
    public func setSessionKey(_ session: String) {
        self.sessionKey = session
    }
    
    @discardableResult
    public func startSession(username: String, password: String) async throws -> SBKSessionResponse {
        let service = AuthSessionService(username: username,
                                         password: password,
                                         apiKey: apiKey,
                                         secretKey: secret)
        let result = try await service.start()
        self.sessionKey = result.info.key
        return result
    }
}
