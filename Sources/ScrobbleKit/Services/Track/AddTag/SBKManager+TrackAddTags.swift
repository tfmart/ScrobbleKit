//
//  SBKManager+TrackAddTags.swift
//  
//
//  Created by Tomas Martins on 14/06/23.
//

import Foundation

public extension SBKManager {
    /**
     Tag a track using a list of user-supplied tags.
     
     - Parameters:
       - track: The name of the track.
       - artist: The name of the artist.
       - tags: A list of user-supplied tags to apply to this track. Accepts a maximum of 10 tags.
     
     - Returns: A boolean value indicating whether the operation was successful.
     
     - Note: See [Last.fm's track.addTags documentation](https://www.last.fm/api/show/track.addTags) for more information.
     */
    @discardableResult
    func addTags(toTrack track: String, artist: String, tags: [String]) async throws -> Bool {
        guard let sessionKey = sessionKey else { throw SBKClientError.missingSessionKey }
        
        let service = AddTagsService(
            to: .track(track, artist: artist),
            tags: tags,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        
        _ = try await service.start()
        return true
    }
    
    /**
     Tag a track using a list of user-supplied tags.
     
     - Parameters:
       - track: The name of the track.
       - artist: The name of the artist.
       - tags: A list of user-supplied tags to apply to this track. Accepts a maximum of 10 tags.
       - completion: The completion handler to call when the request is complete. It returns a boolean indicating success and an optional error.
     
     - Note: See [Last.fm's track.addTags documentation](https://www.last.fm/api/show/track.addTags) for more information.
     */
    func addTags(toTrack track: String, artist: String, tags: [String], completion: ((Bool, Error?) -> Void)?) {
        guard let sessionKey = sessionKey else {
            completion?(false, SBKClientError.missingSessionKey)
            return
        }
        
        let service = AddTagsService(
            to: .track(track, artist: artist),
            tags: tags,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        
        service.start { _, error in
            if let error = error {
                completion?(false, error)
            } else {
                completion?(true, nil)
            }
        }
    }
}
