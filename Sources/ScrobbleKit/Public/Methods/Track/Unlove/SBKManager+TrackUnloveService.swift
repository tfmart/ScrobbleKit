//
//  SBKManager+TrackUnloveService.swift
//  
//
//  Created by Tomas Martins on 15/06/23.
//

import Foundation

public extension SBKManager {
    /**
     Unlove a track on Last.fm.
     
     - Parameters:
       - track: The name of the track.
       - artist: The name of the artist.
     
     - Throws: An error of type `SBKClientError` or `SBKError` if the operation fails.
     
     - Note: See [Last.fm's track.unlove documentation](https://www.last.fm/api/show/track.unlove) for more information.
     */
    func unloveTrack(track: String, artist: String) async throws {
        guard let sessionKey else { throw SBKClientError.missingSessionKey }
        
        let service = TrackUnloveService(
            track: track,
            artist: artist,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        
        _ = try await service.start()
    }
}
