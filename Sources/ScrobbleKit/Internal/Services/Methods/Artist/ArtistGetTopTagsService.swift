//
//  ArtistGetTopTagsService.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 01/05/26.
//

import Foundation

struct ArtistGetTopTagsService: SBKService {
    typealias ResponseType = SBKChartGetTopTagsResponse

    var apiKey: String
    var secretKey: String

    var sbkMethod: SBKMethod = .getTopTagsForArtist
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get

    init(
        searchMethod: SBKArtistSearchMethod,
        autoCorrect: Bool = true,
        apiKey: String,
        secretKey: String
    ) {
        self.apiKey = apiKey
        self.secretKey = secretKey

        var queries: [URLQueryItem] = [
            .init(parameter: .autoCorrect, bool: autoCorrect)
        ]

        switch searchMethod {
        case .artistName(let artist):
            queries.append(.init(name: "artist", value: artist))
        case .musicBrainzID(let mbid):
            queries.append(.init(parameter: .musicBrainzID, value: mbid))
        }

        self.queries = queries
    }
}
