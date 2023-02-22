//
//  ArtistGetTagsService.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

struct ArtistGetTagsService: SBKService {
    typealias ResponseType = SBKAddTagAlbumResponse
    
    var apiKey: String
    var secretKey: String
    
    var sbkMethod: SBKMethod = .getTagsForArtist
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    public init(searchMethod: SBKArtistSearchMethod, user: String?, autocorrect: Bool?, apiKey: String, secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        var queries: [URLQueryItem] = []
        
        switch searchMethod {
        case .artistName(let artist):
            queries.append(URLQueryItem(name: "artist", value: artist))
        case .musicBrainzID(let mbid):
            queries.append(URLQueryItem(name: "mbid", value: mbid))
        }
        
        if let user = user {
            queries.append(URLQueryItem(name: "user", value: user))
        }
        
        if let autocorrect = autocorrect {
            queries.append(URLQueryItem(name: "autocorrect", bool: autocorrect))
        }
        
        self.queries = queries
    }
}
