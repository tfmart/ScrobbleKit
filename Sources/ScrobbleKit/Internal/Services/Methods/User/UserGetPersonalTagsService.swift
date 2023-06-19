//
//  UserGetPersonalTagsService.swift
//  
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

struct UserGetPersonalTagsService: SBKService {
    typealias ResponseType = SBKUserTagsResponse
    
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .getUserPersonalTags
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(user: String, tag: String, taggingType: String, limit: Int = 50, page: Int = 1, apiKey: String, secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        queries = [
            .init(name: "user", value: user),
            .init(name: "tag", value: tag),
            .init(name: "taggingtype", value: taggingType),
            .init(name: "limit", numericValue: limit),
            .init(name: "page", numericValue: page)
        ]
    }
}
