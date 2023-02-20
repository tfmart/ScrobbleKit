//
//  ArtistAddTagsService.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

struct ArtistAddTagsService: SBKAuthenticatedService {
    typealias ResponseType = SBKEmptyResponse
    
    var apiKey: String
    var secretKey: String
    var sessionKey: String
    
    var sbkMethod: SBKMethod = .addTagsToArtist
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .post
    
    init(artist: String, tags: [String], apiKey: String, secretKey: String, sessionKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        self.sessionKey = sessionKey
        
        queries = [
            .init(name: "artist", value: artist),
            .init(name: "tags", value: tags.joined(separator: ","))
        ]
    }
}
