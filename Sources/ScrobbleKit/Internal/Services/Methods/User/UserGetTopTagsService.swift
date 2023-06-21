//
//  UserGetTopTagsService.swift
//  
//
//  Created by Tomas Martins on 20/06/23.
//

import Foundation

struct UserGetTopTagsService: SBKService {
    typealias ResponseType = SBKUserGetTopTagsResponse
    
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .getUserTopTags
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(user: String, limit: Int? = nil, apiKey: String, secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        var queryItems: [URLQueryItem] = [
            .init(name: "user", value: user)
        ]
        
        if let tagLimit = limit {
            queryItems.append(.init(name: "limit", numericValue: tagLimit))
        }
        
        queries = queryItems
    }
}
