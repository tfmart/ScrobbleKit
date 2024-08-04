//
//  ScrobbleService.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

struct ScrobbleService: SBKAuthenticatedService {
    typealias ResponseType = SBKScrobbleList

    var tracks: [SBKTrackToScrobble]
    
    var apiKey: String
    var secretKey: String
    var sessionKey: String
    
    var sbkMethod: SBKMethod = .scrobble
    var queries: [URLQueryItem] = []
    var httpMethod: SBKHttpMethod = .post
    
    init(tracks: [SBKTrackToScrobble], sessionKey: String, apiKey: String, secretKey: String) {
        self.tracks = tracks
        self.sessionKey = sessionKey
        self.apiKey = apiKey
        self.secretKey = secretKey
        
        for (index, track) in tracks.enumerated() {
            queries.append(contentsOf: [
                .init(name: "artist[\(index)]", value: track.artist),
                .init(name: "track[\(index)]", value: track.track),
                .init(name: "timestamp[\(index)]", value: "\(Int(track.timestamp.timeIntervalSince1970))")
            ])
            if let album = track.album {
                queries.append(.init(name: "album[\(index)]", value: album))
            }
            if let albumArtist = track.albumArtist {
                queries.append(.init(name: "albumArtist[\(index)]", value: albumArtist))
            }
            if let trackNumber = track.trackNumber {
                queries.append(.init(name: "trackNumber[\(index)]", value: "\(trackNumber)"))
            }
            if let duration = track.duration {
                queries.append(.init(name: "duration[\(index)]", value: "\(duration)"))
            }
            if let chosenByUser = track.chosenByUser {
                queries.append(.init(name: "chosenByUser[\(index)]", value: chosenByUser ? "1" : "0"))
            }
            if let mbid = track.mbid {
                queries.append(.init(name: "mbid[\(index)]", value: mbid))
            }
        }
    }
}
