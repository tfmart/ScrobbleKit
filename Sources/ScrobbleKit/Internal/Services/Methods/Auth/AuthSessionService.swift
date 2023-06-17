//
//  AuthSessionService.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

struct AuthSessionService: SBKService {
    typealias ResponseType = SBKSessionResponse
    var sbkMethod: SBKMethod = .getSession
    var httpMethod: SBKHttpMethod = .post
    
    var username: String
    var password: String
    
    var apiKey: String
    var secretKey: String
    
    var queries: [URLQueryItem] = []
    
    init(username: String, password: String,
         apiKey: String, secretKey: String) {
        self.username = username
        self.password = password
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        self.queries = [
            .init(name: "username", value: username),
            .init(name: "password", value: password),
        ]
    }
}
