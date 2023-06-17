//
//  SBKTrackUpdateNowPlayingResponse.swift
//  
//
//  Created by Tomas Martins on 11/06/23.
//

import Foundation

struct SBKTrackUpdateNowPlayingResponse: Decodable {
    let nowPlaying: NowPlaying
    
    enum CodingKeys: String, CodingKey {
        case nowPlaying = "nowplaying"
    }
    
    struct NowPlayingCorrectedInfo: Decodable {
        var corrected: String
        var text: String
        
        enum CodingKeys: String, CodingKey {
            case corrected
            case text = "#text"
        }
    }
    
    struct NowPlaying: Decodable {
        let track: NowPlayingCorrectedInfo
        let artist: NowPlayingCorrectedInfo
        let album: NowPlayingCorrectedInfo
        let albumArtist: NowPlayingCorrectedInfo
        let ignoredMessage: IgnoredMessage
        
        enum CodingKeys: String, CodingKey {
            case track, artist, album, albumArtist = "albumArtist", ignoredMessage
        }
    }
    
    struct IgnoredMessage: Decodable {
        let code: SBKTrackUpdateNowPlayingCode?
        
        enum CodingKeys: String, CodingKey {
            case code
        }
    }
}
