//
//  TagGetTopAlbumsService.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

struct TagGetTopAlbumsService: SBKService {
    typealias ResponseType = TagTopAlbumsResponse
    
    var tag: String
    var limit: Int
    var page: Int
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .tagTopAlbums
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

struct TagTopAlbumsResponse: Decodable {
    let albums: [SBKAlbum]
    
    enum CodingKeys: String, CodingKey {
        case albums = "topalbums"
    }
    
    struct TopAlbums: Decodable {
        let album: [SBKAlbum]
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let topAlbums = try container.decode(TopAlbums.self, forKey: .albums)
        self.albums = topAlbums.album
    }
}
