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

struct TagSimilarResponse: Decodable, Sendable {
    let similarTags: [SBKTag]
    
    enum CodingKeys: String, CodingKey {
        case similarTags = "similartags"
    }
    
    struct SimilarTags: Decodable, Sendable {
        let tag: [SBKTag]

        private enum CodingKeys: CodingKey {
            case tag
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.tag = try container.decodeOneOrMany(SBKTag.self, forKey: .tag)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let similar = try container.decode(SimilarTags.self, forKey: .similarTags)
        self.similarTags = similar.tag
    }
}
