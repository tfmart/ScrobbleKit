//
//  TrackSearchService.swift
//  
//
//  Created by Tomas Martins on 15/06/23.
//

import Foundation

struct TrackSearchService: SBKService {
    typealias ResponseType = SBKSearchResultsResponse<SBKTrackSearchResultListResponse>
    
    var sbkMethod: SBKMethod = .searchForTrack
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    var apiKey: String
    var secretKey: String
    
    init(
        track: String,
        artist: String?,
        limit: Int,
        page: Int,
        apiKey: String,
        secretKey: String
    ) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        queries = [
            .init(name: "track", value: track),
            .init(name: "artist", value: artist),
            .init(name: "limit", numericValue: limit),
            .init(name: "page", numericValue: page)
        ]
    }
}
