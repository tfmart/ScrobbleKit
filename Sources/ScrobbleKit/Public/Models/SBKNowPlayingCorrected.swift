//
//  SBKNowPlayingCorrected.swift
//  
//
//  Created by Tomas Martins on 11/06/23.
//

import Foundation

/**
 A struct representing the corrected information after a track update now playing request.
 */
public struct SBKNowPlayingCorrected {
    /**
     Enum representing the types of corrected information.
     */
    public enum SBKNowPlayingInfo {
        case track
        case artist
        case album
        case albumArtist
    }
    
    /// Dictionary containing the corrected information.
    let correctedInformation: [SBKNowPlayingInfo: String]
    
    /**
     Initializes a `SBKNowPlayingCorrected` instance with the provided response.
     
     - Parameter response: The response containing the corrected information.
     */
    init(response: SBKTrackUpdateNowPlayingResponse) {
        var corrected: [SBKNowPlayingInfo: String] = [:]
        
        if response.nowPlaying.track.corrected == "1" {
            corrected[.track] = response.nowPlaying.track.text
        }
        
        if response.nowPlaying.artist.corrected == "1" {
            corrected[.artist] = response.nowPlaying.artist.text
        }
        
        if response.nowPlaying.album.corrected == "1" {
            corrected[.album] = response.nowPlaying.album.text
        }
        
        if response.nowPlaying.albumArtist.corrected == "1" {
            corrected[.albumArtist] = response.nowPlaying.albumArtist.text
        }
        
        self.correctedInformation = corrected
    }
}
