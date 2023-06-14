//
//  TrackGetTagsService.swift
//  
//
//  Created by Tomas Martins on 14/06/23.
//

import Foundation

struct TrackGetTagsService: SBKOptionallyAuthenticatedService {
    var username: String?
    var sessionKey: String?
    
    var apiKey: String
    var secretKey: String
    
    typealias ResponseType = SBKTagRequestResponse
    
    var sbkMethod: SBKMethod = .getTagsForTrack
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(searchMethod: SBKTrackSearchMethod,
         autoCorrect: Bool = true,
         username: String?,
         apiKey: String,
         secretKey: String,
         sessionKey: String?) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        self.sessionKey = sessionKey
        self.username = username
        
        var queries: [URLQueryItem] = [
            .init(parameter: .autoCorrect, bool: autoCorrect)
        ]
        
        switch searchMethod {
        case .trackInfo(let title, artist: let artist):
            queries.append(contentsOf: [
                .init(name: "track", value: title),
                .init(name: "artist", value: artist)
            ])
        case .musicBrainzID(let mbid):
            queries.append(.init(parameter: .musicBrainzID, value: mbid))
        }
        
        self.queries = queries
    }
}
