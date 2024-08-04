//
//  TagGetTopTagsService.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

struct TagGetTopTagsService: SBKService {
    typealias ResponseType = TagTopTagsResponse
    
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .tagTopTags
    var queries: [URLQueryItem] = []
    var httpMethod: SBKHttpMethod = .get
    
    init(apiKey: String, secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
    }
}

struct TagTopTagsResponse: Decodable {
    let tags: [SBKTag]
}
