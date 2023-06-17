//
//  TrackUpdateNowPlayingService.swift
//  
//
//  Created by Tomas Martins on 11/06/23.
//

import Foundation

struct TrackUpdateNowPlayingService: SBKAuthenticatedService {
    var sessionKey: String
    
    typealias ResponseType = SBKTrackUpdateNowPlayingResponse
    
    var sbkMethod: SBKMethod = .updateNowPlaying
    var queries: [URLQueryItem]
    var httpMethod: SBKHttpMethod = .post
    
    var apiKey: String
    var secretKey: String
    
    init(artist: String,
         track: String,
         album: String?,
         trackNumber: Int?,
         context: String?,
         mbid: String?,
         duration: Int?,
         albumArtist: String?,
         apiKey: String,
         secretKey: String,
         sessionKey: String
    ) {
        self.apiKey = apiKey
        self.secretKey = secretKey
        self.sessionKey = sessionKey
        
        var queries: [URLQueryItem] = [
            .init(name: "artist", value: artist),
            .init(name: "track", value: track)
        ]
        
        if let album = album {
            queries.append(.init(name: "album", value: album))
        }
        
        if let trackNumber = trackNumber {
            queries.append(.init(name: "trackNumber", numericValue: trackNumber))
        }
        
        if let context = context {
            queries.append(.init(name: "context", value: context))
        }
        
        if let mbid = mbid {
            queries.append(.init(name: "mbid", value: mbid))
        }
        
        if let duration = duration {
            queries.append(.init(name: "duration", numericValue: duration))
        }
        
        if let albumArtist = albumArtist {
            queries.append(.init(name: "albumArtist", value: albumArtist))
        }
        
        self.queries = queries
    }
}
