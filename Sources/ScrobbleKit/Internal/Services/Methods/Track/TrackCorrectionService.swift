//
//  TrackCorrectionService.swift
//
//
//  Created by Tomas Martins on 26/04/23.
//

import Foundation

struct TrackCorrectionService: SBKService {
    typealias ResponseType = SBKCorrectedResponse<SBKTrack>

    var sbkMethod: SBKMethod = .getCorrectedTrackInfo
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .get

    var apiKey: String
    var secretKey: String

    init(trackName: String, artistName: String, apiKey: String, secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey

        queries = [
            .init(name: "track", value: trackName),
            .init(name: "artist", value: artistName)
        ]
    }
}
