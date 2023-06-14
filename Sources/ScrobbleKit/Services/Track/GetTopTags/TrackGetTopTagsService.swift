//
//  TrackGetTopTagsService.swift
//  
//
//  Created by Tomas Martins on 14/06/23.
//

import Foundation

struct TrackGetTopTagsService: SBKService {
    var apiKey: String
    var secretKey: String
    
    typealias ResponseType = SBKChartGetTopTagsResponse
    
    var sbkMethod: SBKMethod = .getTopTagsForTrack
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    init(
        searchMethod: SBKTrackSearchMethod,
        autoCorrect: Bool = true,
        apiKey: String,
        secretKey: String
    ) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        var queries: [URLQueryItem] = [
            .init(parameter: .autoCorrect, bool: true),
        ]
        
        switch searchMethod {
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
