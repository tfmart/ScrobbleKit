//
//  TrackUnloveService.swift
//  
//
//  Created by Tomas Martins on 15/06/23.
//

import Foundation

struct TrackUnloveService: SBKAuthenticatedService {
    var apiKey: String
    var secretKey: String
    var sessionKey: String
    
    typealias ResponseType = SBKEmptyResponse
    
    var sbkMethod: SBKMethod = .unloveTrack
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .post
    
    init(
        track: String,
        artist: String,
        apiKey: String,
        secretKey: String,
        sessionKey: String
    ) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        self.sessionKey = sessionKey
        self.queries = [
            .init(name: "track", value: track),
            .init(name: "artist", value: artist)
        ]
    }
}
