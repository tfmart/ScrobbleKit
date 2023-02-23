//
//  ArtistSearchService.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

struct ArtistSearchService: SBKService {
    typealias ResponseType = SBKSearchResultsResponse<SBKArtistSearchResultsList>
    
    var sbkMethod: SBKMethod = .searchForArtist
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    var apiKey: String
    var secretKey: String
    
    init(_ searchQuery: String,
         limit: Int,
         page: Int,
         apiKey: String,
         secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        queries = [
            .init(name: "artist", value: searchQuery),
            .init(name: "limit", numericValue: limit),
            .init(name: "page", numericValue: page)
        ]
    }
}
