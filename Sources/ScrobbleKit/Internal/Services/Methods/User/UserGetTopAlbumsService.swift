//
//  UserGetTopAlbumsService.swift
//  
//
//  Created by Tomas Martins on 20/06/23.
//

import Foundation

struct UserGetTopAlbumsService: SBKService {
    typealias ResponseType = SBKUserGetTopAlbumsResponse
    
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .getUserTopAlbums
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(user: String, period: String? = nil, limit: Int = 50, page: Int = 1, apiKey: String, secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        var queryItems: [URLQueryItem] = [
            .init(name: "user", value: user),
            .init(name: "limit", numericValue: limit),
            .init(name: "page", numericValue: page)
        ]
        
        if let timePeriod = period {
            queryItems.append(.init(name: "period", value: timePeriod))
        }
        
        queries = queryItems
    }
}
