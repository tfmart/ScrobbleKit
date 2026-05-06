//
//  SBKManager+ArtistGetTagsService.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

public extension SBKManager {
    /**
     Asynchronously retrieves the tags applied by an individual user to an artist on Last.fm.
     
     - Parameters:
        - searchMethod: The artist search method, either by name or by MusicBrainz ID.
        - user: The username of the user who applied the tags to the artist. If not provided, all user tags will be returned.
        - autocorrect: A Boolean value indicating whether to correct any misspelled artist names. The default value is `true`.
     
     - Returns: An array of ``SBKTag`` objects representing the tags applied by the user to the artist. If no tags were found, an empty array is returned.
     
     - Throws: An error of type ``SBKClientError`` or an error returned by the Last.fm API.
     
     - Note: See [Last.fm's artist.getTags documentation](https://www.last.fm/api/show/artist.getTags) for more information.
     */
    func getTags(forArtist searchMethod: SBKArtistSearchMethod,
                       user: String? = nil,
                       autocorrect: Bool) async throws -> [SBKTag] {
        let service = ArtistGetTagsService(
            searchMethod: searchMethod,
            user: user,
            autocorrect: autocorrect,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        let response = try await service.start()
        guard let tags = response.tags.tag else {
            return []
        }
        return tags
    }
}
