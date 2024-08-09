//
//  SBKManager+ArtistRemoveTagService.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

public extension SBKManager {

    /**
     Remove a user's tag from an artist on Last.fm.
     
     - Parameters:
        - artist: The name of the artist to remove the tag from.
        - tag: The tag to remove.
     
     - Returns: A boolean value indicating whether the tag was successfully removed.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or the user is not authenticated.
     
     - Note: This method requires user authentication. Make sure the user is logged in before calling this method.
     For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/artist.removeTag).
     */
    @discardableResult
    func removeTag(fromArtist artist: String, tag: String) async throws -> Bool {
        guard let sessionKey else { throw SBKClientError.missingSessionKey }
        let service = RemoveTagService(
            to: .artist(artist),
            tag: tag,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        _ = try await service.start()
        return true
    }
    
    /**
     Remove a user's tag from an artist on Last.fm.
     
     - Parameters:
        - artist: The name of the artist to remove the tag from.
        - tag: The tag to remove.
        - completion: A closure to be called when the request is complete. It returns a boolean indicating success and an optional error.
     
     - Note: This method requires user authentication. Make sure the user is logged in before calling this method.
     For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/artist.removeTag).
     */
    func removeTag(fromArtist artist: String, tag: String, _ completion: ((Bool, Error?) -> Void)?) {
        guard let sessionKey else {
            completion?(false, SBKClientError.missingSessionKey)
            return
        }
        let service = RemoveTagService(
            to: .artist(artist),
            tag: tag,
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
