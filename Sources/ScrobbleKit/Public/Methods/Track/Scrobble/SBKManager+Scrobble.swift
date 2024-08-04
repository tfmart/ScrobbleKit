//
//  SBKManager.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

public extension SBKManager {
    /// Scrobbles multiple tracks to a user's Last.fm profile.
    ///
    /// - Parameter tracks: An array of `SBKTrackToScrobble` objects representing the tracks to be scrobbled.
    /// - Returns: An `SBKScrobbleResponse` object containing information about the scrobbled tracks.
    /// - Throws: An error if the scrobbling process fails, including `SBKClientError.noTracksToScrobble` if the tracks array is empty,
    ///           `SBKClientError.tooManyTracks` if more than 50 tracks are provided, or `SBKClientError.missingSessionKey` if not authenticated.
    ///
    /// - Note: You can scrobble up to 50 tracks in a single request.
    /// - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/track.scrobble).
    func scrobble(tracks: [SBKTrackToScrobble]) async throws -> SBKScrobbleResponse {
        guard !tracks.isEmpty else {
            throw SBKClientError.noTracksToScrobble
        }
        
        if tracks.count > 50 {
            throw SBKClientError.tooManyTracks
        }
        
        guard let sessionKey else { throw SBKClientError.missingSessionKey }
        let service = ScrobbleService(
            tracks: tracks,
            sessionKey: sessionKey,
            apiKey: self.apiKey,
            secretKey: self.secret
        )
        do {
            let responseList = try await service.start()
            return SBKScrobbleResponse(list: responseList)
        } catch {
            throw error
        }
    }
    
    /// Scrobbles multiple tracks to a user's Last.fm profile using a completion handler.
    ///
    /// - Parameters:
    ///   - tracks: An array of `SBKTrackToScrobble` objects representing the tracks to be scrobbled.
    ///   - completion: A closure to be executed when the scrobbling process completes.
    ///                 It returns an optional `SBKScrobbleResponse` object and an optional `Error`.
    ///
    /// - Note: You can scrobble up to 50 tracks in a single request.
    ///         The completion handler will be called with an error if the tracks array is empty,
    ///         contains more than 50 tracks, or if the user is not authenticated.
    func scrobble(tracks: [SBKTrackToScrobble], _ completion: ((SBKScrobbleResponse?, Error?) -> Void)? = nil) {
        guard !tracks.isEmpty else {
            completion?(nil, SBKClientError.noTracksToScrobble)
            return
        }
        
        if tracks.count > 50 {
            completion?(nil, SBKClientError.tooManyTracks)
            return
        }
        
        guard let sessionKey else {
            completion?(nil, SBKClientError.missingSessionKey)
            return
        }
        let service = ScrobbleService(
            tracks: tracks,
            sessionKey: sessionKey,
            apiKey: self.apiKey,
            secretKey: self.secret
        )
        service.start { list, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let list else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(SBKScrobbleResponse(list: list), nil)
        }
    }
}
