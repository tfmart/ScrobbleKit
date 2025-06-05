//
//  SBKManager+TrackRemoveTag.swift
//  
//
//  Created by Tomas Martins on 14/06/23.
//

import Foundation

public extension SBKManager {
    /**
     Remove a user's tag from a track on Last.fm.
     
     - Parameters:
     - track: The name of the track.
     - artist: The name of the artist.
     - tag: The tag to remove from the track.
     
     - Returns: A boolean value indicating whether the tag was removed from the track.
     
     - Note: See [Last.fm's track.removeTag documentation](https://www.last.fm/api/show/track.removeTag) for more information.
     */
    @discardableResult
    func removeTag(fromTrack track: String, artist: String, tag: String) async throws -> Bool {
        guard let sessionKey = sessionKey else { throw SBKClientError.missingSessionKey }
        
        let service = RemoveTagService(
            to: .track(track, artist: artist),
            tag: tag,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        
        _ = try await service.start()
        return true
    }
}
