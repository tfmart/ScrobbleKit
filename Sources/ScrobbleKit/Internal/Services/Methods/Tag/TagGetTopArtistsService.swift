//
//  TagGetTopArtistsService.swift
//
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

import Foundation

struct TagGetTopArtistsService: SBKService {
    typealias ResponseType = TagTopArtistsResponse
    
    var tag: String
    var limit: Int
    var page: Int
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
    let artists: [SBKArtist]
    
    enum CodingKeys: String, CodingKey {
        case artists = "topartists"
    }
    
    struct TopArtists: Decodable {
        let artist: [SBKArtist]
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let topArtists = try container.decode(TopArtists.self, forKey: .artists)
        self.artists = topArtists.artist
    }
}
