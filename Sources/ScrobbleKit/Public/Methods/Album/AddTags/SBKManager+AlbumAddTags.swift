//
//  SBKManager+AlbumAddTags.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

public extension SBKManager {
    /**
     Tag an album using a list of user-supplied tags.
     
     - Parameters:
       - artist: The name of the artist.
       - album: The name of the album.
       - tags: A list of user-supplied tags to apply to this album. **Accepts a maximum of 10 tags.**
     
     - Returns: A boolean value indicating whether the operation was successful.
     
     - Note: See [Last.fm's album.addTags documentation](https://www.last.fm/api/show/album.addTags) for more information.
     */
    @discardableResult
    func addTags(toAlbum album: String, artist: String, tags: [String]) async throws -> Bool {
        guard let sessionKey else { throw SBKClientError.missingSessionKey }
        let service = try AddTagsService(to: .album(album, artist: artist),
                                         tags: tags,
                                         apiKey: apiKey,
                                         secretKey: secret,
                                         sessionKey: sessionKey)
        _ = try await service.start()
        return true
    }
}
