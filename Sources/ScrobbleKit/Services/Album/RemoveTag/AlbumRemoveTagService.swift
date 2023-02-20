//
//  AlbumRemoveTagService.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

struct AlbumRemoveTagService: SBKAuthenticatedService {
    typealias ResponseType = SBKEmptyResponse
    
    var apiKey: String
    var secretKey: String
    var sessionKey: String
    
    var sbkMethod: SBKMethod = .removeTagFromAlbum
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .post
    
    init(album: String, artist: String, tag: String, apiKey: String, secretKey: String, sessionKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        self.sessionKey = sessionKey
        
        queries = [
            .init(name: "album", value: album),
            .init(name: "artist", value: artist),
            .init(name: "tag", value: tag)
        ]
    }
}
