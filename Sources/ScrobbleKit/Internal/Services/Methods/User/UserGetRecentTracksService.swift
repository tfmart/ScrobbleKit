//
//  UserGetRecentTracksService.swift
//  
//
//  Created by Tomas Martins on 20/06/23.
//

import Foundation

struct UserGetRecentTracksService: SBKService {
    typealias ResponseType = SBKUserGetRecentTracksResponse
    
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .recentTracks
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(user: String,
         limit: Int = 50,
         page: Int = 1,
         from: TimeInterval? = nil,
         extended: Bool? = nil,
         to: TimeInterval? = nil,
         apiKey: String,
         secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        var queryItems: [URLQueryItem] = [
            .init(name: "user", value: user),
            .init(name: "limit", numericValue: limit),
            .init(name: "page", numericValue: page)
        ]
        
        if let fromTimestamp = from {
            queryItems.append(.init(name: "from", numericValue: Int(fromTimestamp)))
        }
        
        if let extendedData = extended {
            queryItems.append(.init(name: "extended", bool: extendedData))
        }
        
        if let toTimestamp = to {
            queryItems.append(.init(name: "to", numericValue: Int(toTimestamp)))
        }
        
        queries = queryItems
    }
}
