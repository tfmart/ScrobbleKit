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
        - completion: A closure to be executed when the request is complete. It returns a boolean indicating success and an optional error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/track.love).
     */
    @available(swift, deprecated: 5.10, obsoleted: 6.0, message: "Completion handler APIs will be removed in a future version; please migrate to the async version of this method")
    func loveTrack(
        track: String,
        artist: String,
        completion: ((Bool?, Error?) -> Void)?
    ) {
        guard let sessionKey else {
            completion?(nil, SBKClientError.missingSessionKey)
            return
        }
        let service = TrackLoveService(
            track: track,
            artist: artist,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        
        service.start { (_, error) in
            if let error = error {
                completion?(false, error)
            } else {
                completion?(true, nil)
            }
        }
    }
    
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
