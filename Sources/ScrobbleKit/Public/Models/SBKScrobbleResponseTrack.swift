//
//  SBKScrobbleResponseTrack.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

/// Represents information about a song that has been attempted to be scrobbled.
public struct SBKScrobbleResponseTrack {
    /// The artist of the track for the attempted scrobble.
    public let artist: String
    /// The title of the track for the attempted scrobble.
    public let title: String
    /// The album of the track for the attempted scrobble. (Optional)
    public let album: String?
    /// The timestamp of the scrobble attempt.
    public let timestamp: String
    /// A list of fields corrected by Last.fm. If empty, no attributes have been corrected.
    public let correctedAttributes: [SBKScrobbleResponseAttribute]
    /// The scrobble status of the track, indicating whether it has been successfully logged or ignored by Last.fm, with an accompanying error message.
    public let status: SBKScrobbleResponseTrackStatus
}
