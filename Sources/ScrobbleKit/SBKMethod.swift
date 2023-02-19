//
//  SBKMethod.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

enum SBKMethod: String {
    // Auth
    case getSession = "auth.getMobileSession"
    // Scrobble
    case scrobble = "track.scrobble"
    // Recent tracks
    case recentTracks = "user.getRecentTracks"
    // Love Track
    case loveTrack = "track.love"
    // Now Playing
    case nowPlaying = "track.updateNowPlaying"
}
