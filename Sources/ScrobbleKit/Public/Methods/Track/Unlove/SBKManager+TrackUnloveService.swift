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
    
    /**
     Unlove a track on Last.fm.
     
     - Parameters:
       - track: The name of the track.
       - artist: The name of the artist.
       - completion: The completion handler to call when the request is complete. It returns a boolean value indicating whether the operation was successful and an optional error.
     
     - Note: See [Last.fm's track.unlove documentation](https://www.last.fm/api/show/track.unlove) for more information.
     */
    @available(swift, deprecated: 5.10, obsoleted: 6.0, message: "Completion handler APIs will be removed in a future version; please migrate to the async version of this method")
    func unloveTrack(track: String, artist: String, completion: ((Bool, Error?) -> Void)?) {
        guard let sessionKey else {
            completion?(false, SBKClientError.missingSessionKey)
            return
        }
        
        let service = TrackUnloveService(
            track: track,
            artist: artist,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        
        service.start { response, error in
            guard error == nil else {
                completion?(false, error)
                return
            }
            guard response != nil else {
                completion?(false, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(true, nil)
        }
    }
}
