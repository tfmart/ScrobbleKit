//
//  ArtistGetSimilarService.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

struct ArtistGetSimilarService: SBKService {
    typealias ResponseType = SBKArtistGetSimilarResponse
    
    var sbkMethod: SBKMethod = .getSimilarArtists
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    var apiKey: String
    var secretKey: String
    
    init(_ searchMethod: SBKArtistSearchMethod,
         limit: Int,
         autoCorrect: Bool,
         apiKey: String,
         secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey

        switch searchMethod {
        case .artistName(let artist):
            queries = [
                .init(name: "artist", value: artist),
                .init(name: SBKParameter.autoCorrect.rawValue, bool: autoCorrect),
                .init(name: "limit", numericValue: limit)
            ]
        case .musicBrainzID(let mbid):
            queries = [
                .init(name: SBKParameter.musicBrainzID.rawValue, value: mbid),
                .init(name: SBKParameter.autoCorrect.rawValue, bool: autoCorrect),
                .init(name: "limit", numericValue: limit)
            ]
        }
    }
}
