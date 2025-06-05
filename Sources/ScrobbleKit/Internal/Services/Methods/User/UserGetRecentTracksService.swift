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
         from: Date? = nil,
         extended: Bool? = nil,
         to: Date? = nil,
         apiKey: String,
         secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        var queryItems: [URLQueryItem] = [
            .init(name: "user", value: user),
            .init(name: "limit", numericValue: limit),
            .init(name: "page", numericValue: page)
        ]
        
        if let fromDate = from {
            queryItems.append(.init(name: "from", numericValue: Int(fromDate.timeIntervalSince1970)))
        }
        
        if let extendedData = extended {
            queryItems.append(.init(name: "extended", bool: extendedData))
        }
        
        if let toDate = to {
            queryItems.append(.init(name: "to", numericValue: Int(toDate.timeIntervalSince1970)))
        }
        
        queries = queryItems
    }
}
