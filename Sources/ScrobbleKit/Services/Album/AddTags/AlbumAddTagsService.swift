//
//  AlbumAddTagsService.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

struct AlbumAddTagsService: SBKAuthenticatedService {
    typealias ResponseType = SBKEmptyResponse
    
    var apiKey: String
    var secretKey: String
    var sessionKey: String
    
    var sbkMethod: SBKMethod = .addTagsToAlbum
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .post
    
    init(album: String, artist: String, tags: [String], apiKey: String, secretKey: String, sessionKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        self.sessionKey = sessionKey
        
        queries = [
            .init(name: "album", value: album),
            .init(name: "artist", value: artist),
            .init(name: "tags", value: tags.joined(separator: ","))
        ]
    }
}
