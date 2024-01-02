//
//  SBKScrobbleResponseTrackStatus.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

/// Represents the scrobble status of a song, indicating whether it has been successfully scrobbled or ignored.
public enum SBKScrobbleResponseTrackStatus {
    /// The song has been scrobbled successfully.
    case accepted
    /// The song has been ignored by the scrobble service.
    /// - Parameter message: A message describing the cause for ignoring the song, if available.
    case ignored(message: String?)
}
