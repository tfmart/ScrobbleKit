//
//  UserGetInfoService.swift
//  
//
//  Created by Tomas Martins on 25/04/23.
//

import Foundation

struct UserGetInfoService: SBKOptionallyAuthenticatedService {
    var username: String?
    var sessionKey: String?
    
    typealias ResponseType = SBKUserInfoResponse
    
    var sbkMethod: SBKMethod = .getUserInfo
    var queries: [URLQueryItem] = []
    var httpMethod: SBKHttpMethod = .get
    
    var apiKey: String
    var secretKey: String
    
    init(username: String?, apiKey: String, secretKey: String, sessionKey: String?) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        self.sessionKey = sessionKey
        self.username = username
    }
}
