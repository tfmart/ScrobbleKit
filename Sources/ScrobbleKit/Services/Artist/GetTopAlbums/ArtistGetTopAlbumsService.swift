//
//  ArtistGetTopAlbumsService.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

struct ArtistGetTopAlbumsService: SBKService {
    typealias ResponseType = SBKArtistGetTopAlbumsResponse
    
    var sbkMethod: SBKMethod = .getTopAlbumsForArtist
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get
    
    var apiKey: String
    var secretKey: String
    
    init(_ searchMethod: SBKArtistSearchMethod,
         limit: Int,
         page: Int,
         autoCorrect: Bool,
         apiKey: String,
         secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey

        switch searchMethod {
        case .artistName(let artist):
            queries = [
                .init(name: "artist", value: artist),
                .init(name: "limit", numericValue: limit),
                .init(name: "page", numericValue: page),
                .init(name: SBKParameter.autoCorrect.rawValue, bool: autoCorrect),
            ]
        case .musicBrainzID(let mbid):
            queries = [
                .init(name: SBKParameter.musicBrainzID.rawValue, value: mbid),
                .init(name: "limit", numericValue: limit),
                .init(name: "page", numericValue: page),
                .init(name: SBKParameter.autoCorrect.rawValue, bool: autoCorrect),
            ]
        }
    }
}
