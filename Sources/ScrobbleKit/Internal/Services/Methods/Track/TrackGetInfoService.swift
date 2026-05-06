//
//  TrackGetInfoService.swift
//  
//
//  Created by Tomas Martins on 26/04/23.
//

import Foundation

struct TrackGetInfoService: SBKService {
    var apiKey: String
    var secretKey: String

    typealias ResponseType = SBKTrackRequestResponseList
    
    var sbkMethod: SBKMethod = .getTrackInfo
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get

    init(
        searchMethod: SBKTrackSearchMethod,
        username: String? = nil,
        autoCorrect: Bool = true,
        apiKey: String,
        secretKey: String
    ) {
        self.apiKey = apiKey
        self.secretKey = secretKey

        var queries: [URLQueryItem] = [
            .init(name: SBKParameter.autoCorrect.rawValue, bool: autoCorrect),
            .init(name: "username", value: username)
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
