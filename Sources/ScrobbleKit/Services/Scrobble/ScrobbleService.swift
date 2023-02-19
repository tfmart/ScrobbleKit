//
//  ScrobbleService.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

struct ScrobbleService: SBKService {
    typealias ResponseType = SBKScrobbleList

    var artist: String
    var track: String
    var album: String?
    var timestamp: Int
    
    var apiKey: String
    var secretKey: String
    var sessionKey: String
    
    var sbkMethod: SBKMethod = .scrobble
    var queries: [URLQueryItem] = []
    var httpMethod: SBKHttpMethod = .post
    
    init(artist: String, track: String, album: String?, date: Date, sessionKey: String, apiKey: String, secretKey: String) {
        self.artist = artist
        self.track = track
        self.album = album
        self.timestamp = Int(date.timeIntervalSince1970)
        self.sessionKey = sessionKey
        self.apiKey = apiKey
        self.secretKey = secretKey
        self.queries = [
            .init(name: "artist", value: artist),
            .init(name: "track", value: track),
            .init(name: "album", value: album),
            .init(name: "timestamp", value: "\(timestamp)"),
            .init(name: "sk", value: sessionKey),
        ]
    }
}
