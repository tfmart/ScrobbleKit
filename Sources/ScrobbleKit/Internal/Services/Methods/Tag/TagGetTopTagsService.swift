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
    
    enum CodingKeys: String, CodingKey {
        case tags = "toptags"
    }
    
    struct TopTags: Decodable {
        let tag: [SBKTag]
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let topTags = try container.decode(TopTags.self, forKey: .tags)
        self.tags = topTags.tag
    }
}
