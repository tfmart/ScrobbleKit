//
//  SBKManager.swift
//
//
//  Created by Tomas Martins on 19/02/23.
//

public class SBKManager {
    internal let apiKey: String
    internal let secret: String
    internal var sessionKey: String?
    
    public init(apiKey: String, secret: String) {
        self.apiKey = apiKey
        self.secret = secret
    }
}
