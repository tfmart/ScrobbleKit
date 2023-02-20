//
//  AlbumSearchService.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

struct AlbumSearchService: SBKService {
    typealias ResponseType = SBKAlbum
    
    var sbkMethod: SBKMethod = .searchForAlbum
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    var apiKey: String
    var secretKey: String
    
    init(album: String, limit: Int, page: Int, apiKey: String, secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        queries = [
            .init(name: "album", value: album),
            .init(name: "limit", numericValue: limit),
            .init(name: "page", numericValue: page)
        ]
    }
}
