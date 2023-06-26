//
//  SBKManager+AlbumRemoveTagService.swift
//  
//
//  Created by Tomas Martins on 20/02/23.
//

import Foundation

public extension SBKManager {
    /**
      Remove a user's tag from an album on Last.fm.

      - Parameter album: The name of the album.
      - Parameter artist: The name of the album's artist.
      - Parameter tag: The tag to remove from the album.
      - Returns: A Boolean value indicating whether the tag was removed from the album.
      - Throws: An error of type ``SBKClientError``or ``SBKError`` if the operation fails

     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/album.removeTag).
    */
    @discardableResult
    func removeTag(fromAlbum album: String, artist: String, tag: String) async throws -> Bool {
        guard let sessionKey else { throw SBKClientError.missingSessionKey }
        let service = RemoveTagService(
            to: .album(album, artist: artist),
            tag: tag,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        _ = try await service.start()
        return true
    }
    
    /**
      Remove a user's tag from an album on Last.fm API.

      - Parameter album: The name of the album.
      - Parameter artist: The name of the artist.
      - Parameter tag: The tag to remove from the album.
      - Parameter completion: A completion block to be called with the result of the operation.

      - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/album.removeTag).
    */
    func removeTag(fromAlbum album: String, artist: String, tag: String, _ completion: ((Bool, Error?) -> Void)?) {
        guard let sessionKey else {
            completion?(false, SBKClientError.missingSessionKey)
            return
        }
        let service = RemoveTagService(
            to: .album(album, artist: artist),
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
