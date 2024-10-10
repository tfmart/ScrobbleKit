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
        - completion: A closure to be executed when the request is complete. It returns optional strings with the corrected track and artist names, and an optional error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/track.getCorrection).
     */
    @available(swift, deprecated: 5.10, obsoleted: 6.0, message: "Completion handler APIs will be removed in a future version; please migrate to the async version of this method")
    func getCorrectedTrackInfo(
        for trackName: String,
        by artistName: String,
        _ completion: ((SBKTrack?, Error?) -> Void)?
    ) {
        let service = TrackCorrectionService(trackName: trackName, artistName: artistName, apiKey: apiKey, secretKey: secret)
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let response = response else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(response.corrections.correction.result, nil)
        }
    }
    
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

