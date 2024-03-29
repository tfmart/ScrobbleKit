//
//  SBKTrackGetSimilarResponse.swift
//  
//
//  Created by Tomas Martins on 14/06/23.
//

import Foundation

struct SBKTrackGetSimilarResponse: Decodable {
    var similarTracks: SBKTrackGetSimilarList
    
    enum CodingKeys: String, CodingKey {
        case similarTracks = "similartracks"
    }
}

struct SBKTrackGetSimilarList: Decodable {
    var tracks: [SBKTrackGetSimilarListTrack]
    
    enum CodingKeys: String, CodingKey {
        case tracks = "track"
    }
}

struct SBKTrackGetSimilarListTrack: Decodable {
    var name: String
    var playcount: Int
    var mbid: String?
    var match: Double?
    var url: String
    var duration: Int?
    var artist: SBKArtist
    var image: [SBKImageResponse]
}

extension SBKSimilarTrack {
    init(similarTrack: SBKTrackGetSimilarListTrack) {
        var duration: String? {
            if let duration = similarTrack.duration {
                return "\(duration)"
            } else {
                return nil
            }
        }
        
        let track = SBKTrack(name: similarTrack.name,
                             mbid: similarTrack.mbid,
                             playcount: "\(similarTrack.playcount)",
                             listeners: nil,
                             duration: duration,
                             artist: similarTrack.artist,
                             url: URL(string: similarTrack.url),
                             imageList: similarTrack.image)
        
        self.init(track: track, match: similarTrack.match)
    }
}
