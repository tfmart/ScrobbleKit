//
//  UserGetFriendsService.swift
//  
//
//  Created by Tomas Martins on 15/06/23.
//

import Foundation

struct UserGetFriendsService: SBKService {
    typealias ResponseType = SBKUserGetFriendsRootObject
    
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .getUserFriends
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(
        user: String,
        recentTracks: Bool,
        limit: Int,
        page: Int,
        apiKey: String,
        secretKey: String
    ) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        queries = [
            .init(name: "user", value: user),
            .init(name: "recenttracks", bool: recentTracks),
            .init(name: "limit", numericValue: limit),
            .init(name: "page", numericValue: page)
        ]
    }
}
