//
//  TrackGetSimilarService.swift
//  
//
//  Created by Tomas Martins on 14/06/23.
//

import Foundation

class TrackGetSimilarService: SBKService {
    var apiKey: String
    var secretKey: String
    
    typealias ResponseType = SBKTrackGetSimilarResponse
    
    var sbkMethod: SBKMethod = .getSimilarTracks
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(
        track: SBKTrackSearchMethod,
        autoCorrect: Bool = true,
        limit: Int? = nil,
        apiKey: String,
        secretKey: String
    ) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        var queries: [URLQueryItem] = [
            .init(parameter: .autoCorrect, bool: autoCorrect),
            .init(name: "limit", numericValue: limit)
        ]
        
        
        switch track {
        case .trackInfo(let title, let artist):
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

