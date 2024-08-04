//
//  SBKScrobbleResult.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

/// Represents the result of a scrobble attempt for a single track.
public struct SBKScrobbleResult: Equatable {
    /// The track that was attempted to be scrobbled.
    public let track: SBKTrackToScrobble
    /// Indicates whether the scrobble was accepted by Last.fm.
    public let isAccepted: Bool
    /// The error that occurred during scrobbling, if any.
    public let error: SBKScrobbleError?
    /// The corrected track name, if Last.fm made a correction.
    public let correctedTrack: String?
    /// The corrected artist name, if Last.fm made a correction.
    public let correctedArtist: String?
    /// The corrected album name, if Last.fm made a correction.
    public let correctedAlbum: String?
    /// The corrected album artist name, if Last.fm made a correction.
    public let correctedAlbumArtist: String?
}
