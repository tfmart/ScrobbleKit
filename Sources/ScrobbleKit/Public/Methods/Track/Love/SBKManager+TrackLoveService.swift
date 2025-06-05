//
//  SBKManager+TrackLoveService.swift
//  
//
//  Created by Tomas Martins on 14/06/23.
//

import Foundation

public extension SBKManager { 
    /**
     Marks a track as loved for the authenticated user.
     
     - Parameters:
        - track: The name of the track.
        - artist: The name of the artist.
     
     - Throws: An error of type `SBKClientError` or `SBKError` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/track.love).
     */
    func loveTrack(
        track: String,
        artist: String
    ) async throws {
        guard let sessionKey else {
            throw SBKClientError.missingSessionKey
        }
        
        let service = TrackLoveService(
            track: track,
            artist: artist,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        
        _ = try await service.start()
    }
}
