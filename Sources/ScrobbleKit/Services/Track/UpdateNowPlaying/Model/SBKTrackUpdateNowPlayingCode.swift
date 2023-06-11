//
//  SBKTrackUpdateNowPlayingCode.swift
//  
//
//  Created by Tomas Martins on 11/06/23.
//

import Foundation

/**
 Enum representing the error codes for the track update now playing service.
 */
enum SBKTrackUpdateNowPlayingCode: String, Error, Decodable {
    case ok = "0"
    case ignoredArtist = "1"
    case ignoredTrack = "2"
    case tooOldTimestamp = "3"
    case tooNewTimestamp = "4"
    case dailyScrobbleLimitExceeded = "5"
}
