//
//  TagGetTopTracksService.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

import Foundation

struct TagGetTopTracksService: SBKService {
    typealias ResponseType = TagTopTracksResponse
    
    var tag: String
    var limit: Int
    var page: Int
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .tagTopTracks
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

struct TagTopTracksResponse: Decodable {
    let tracks: [SBKTrack]
    
    enum CodingKeys: String, CodingKey {
        case tracks = "toptracks"
    }
    
    struct TopTracks: Decodable {
        let track: [SBKTrack]
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let topTracks = try container.decode(TopTracks.self, forKey: .tracks)
        self.tracks = topTracks.track
    }
}
