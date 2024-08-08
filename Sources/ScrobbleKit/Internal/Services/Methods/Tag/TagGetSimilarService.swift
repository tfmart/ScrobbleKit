//
//  TagGetSimilarService.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

struct TagGetSimilarService: SBKService {
    typealias ResponseType = TagSimilarResponse
    
    var tag: String
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .tagSimilar
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(tag: String, apiKey: String, secretKey: String) {
        self.tag = tag
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        self.queries = [
            .init(name: "tag", value: tag)
        ]
    }
}

struct TagSimilarResponse: Decodable {
    let similarTags: [SBKTag]
    
    enum CodingKeys: String, CodingKey {
        case similarTags = "similartags"
    }
    
    struct SimilarTags: Decodable {
        let tag: [SBKTag]
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let similar = try container.decode(SimilarTags.self, forKey: .similarTags)
        self.similarTags = similar.tag
    }
}
