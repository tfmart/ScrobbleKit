//
//  TagGetTopArtistsService.swift
//
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

struct TagGetTopArtistsService: SBKService {
    typealias ResponseType = TagTopArtistsResponse
    
    let tag: String
    let limit: Int
    let page: Int
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .tagTopArtists
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(tag: String, limit: Int, page: Int, apiKey: String, secretKey: String) {
        self.tag = tag
        self.limit = limit
        self.page = page
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        self.queries = [
            .init(name: "tag", value: tag),
            .init(name: "limit", value: "\(limit)"),
            .init(name: "page", value: "\(page)")
        ]
    }
}

struct TagTopArtistsResponse: Decodable {
    let artists: [SBKTaggedItem]
}
