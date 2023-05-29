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
        track: String,
        artist: String,
        mbid: String? = nil,
        username: String? = nil,
        autoCorrect: Bool = true,
        apiKey: String,
        secretKey: String
    ) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        self.queries = [
            .init(name: "track", value: track),
            .init(name: "artist", value: artist),
            .init(name: SBKParameter.autoCorrect.rawValue, bool: autoCorrect),
            .init(name: "username", value: username),
            .init(name: "mbid", value: mbid)
        ]
    }
}
