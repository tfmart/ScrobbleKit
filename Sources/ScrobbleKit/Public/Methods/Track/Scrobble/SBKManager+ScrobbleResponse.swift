//
//  File.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

public extension SBKManager {
    /// Checks if a specific track was successfully scrobbled in the given response.
    /// - Parameters:
    ///   - track: The track to check.
    ///   - response: The scrobble response to check against.
    /// - Returns: `true` if the track was successfully scrobbled, `false` otherwise.
    func scrobbledSuccessfully(_ track: SBKTrackToScrobble, in response: SBKScrobbleResponse) -> Bool {
        return response.results.first { $0.track == track }?.isAccepted ?? false
    }
    
    /// Retrieves the error for a specific track in the given response, if any.
    /// - Parameters:
    ///   - track: The track to check for errors.
    ///   - response: The scrobble response to check against.
    /// - Returns: The `SBKScrobbleError` for the track if it exists, `nil` otherwise.
    func errorFor(_ track: SBKTrackToScrobble, in response: SBKScrobbleResponse) -> SBKScrobbleError? {
        return response.results.first { $0.track == track }?.error
    }
}
