//
//  SBKScrobbleResponse.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

import Foundation

/// Represents the response from a scrobble request to Last.fm.
public struct SBKScrobbleResponse {
    /// The results for each track that was attempted to be scrobbled.
    public let results: [SBKScrobbleResult]
    /// The number of tracks that were successfully scrobbled.
    public let acceptedCount: Int
    /// The number of tracks that were ignored (failed to scrobble).
    public let ignoredCount: Int
    
    /// Indicates whether all tracks were successfully scrobbled.
    public var isCompletelySuccessful: Bool {
        return ignoredCount == 0
    }
    
    /// A list of tracks that were successfully scrobbled.
    public var acceptedScrobbles: [SBKScrobbleResult] {
        return results.filter { $0.isAccepted }
    }
    
    /// A list of tracks that failed to scrobble.
    public var ignoredScrobbles: [SBKScrobbleResult] {
        return results.filter { !$0.isAccepted }
    }
    
    internal init(list: SBKScrobbleList) {
        self.results = list.scrobbles.scrobbles.enumerated().map { (index, sbkScrobble) in
            let track = SBKTrackToScrobble(
                artist: sbkScrobble.artist.text ?? "",
                track: sbkScrobble.track.text ?? "",
                timestamp: Date(timeIntervalSince1970: TimeInterval(sbkScrobble.timestamp) ?? 0),
                album: sbkScrobble.album.text
            )
            
            let isAccepted = sbkScrobble.ignoredMessage.code == "0"
            let error = isAccepted ? nil : SBKScrobbleError(code: sbkScrobble.ignoredMessage.code)
            
            return SBKScrobbleResult(
                track: track,
                isAccepted: isAccepted,
                error: error,
                correctedTrack: sbkScrobble.track.corrected == "1" ? sbkScrobble.track.text : nil,
                correctedArtist: sbkScrobble.artist.corrected == "1" ? sbkScrobble.artist.text : nil,
                correctedAlbum: sbkScrobble.album.corrected == "1" ? sbkScrobble.album.text : nil,
                correctedAlbumArtist: sbkScrobble.albumArtist.corrected == "1" ? sbkScrobble.albumArtist.text : nil
            )
        }
        
        self.acceptedCount = list.scrobbles.attr.accepted
        self.ignoredCount = list.scrobbles.attr.ignored
    }
}
