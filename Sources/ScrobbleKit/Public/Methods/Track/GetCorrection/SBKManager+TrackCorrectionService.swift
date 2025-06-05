//
//  SBKManager+TrackCorrectionService.swift
//  
//
//  Created by Tomas Martins on 26/04/23.
//

import Foundation

public extension SBKManager {
    /**
     Retrieves the corrected artist and track names for a given track name and artist name.
     
     - Parameters:
        - trackName: The name of the track to correct.
        - artistName: The name of the artist to correct.
     
     - Returns: The corrected track and artist names as optional strings.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/track.getCorrection).
     */
    func getCorrectedTrackInfo(
        for trackName: String,
        by artistName: String
    ) async throws -> SBKTrack? {
        let service = TrackCorrectionService(trackName: trackName, artistName: artistName, apiKey: apiKey, secretKey: secret)
        let response = try await service.start()
        return response.corrections.correction.result
    }
}

