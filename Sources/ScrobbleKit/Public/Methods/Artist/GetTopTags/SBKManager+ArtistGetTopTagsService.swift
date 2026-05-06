//
//  SBKManager+ArtistGetTopTagsService.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 01/05/26.
//

import Foundation

public extension SBKManager {
    /**
     Get the top tags for an artist on Last.fm, ordered by popularity.

     - Parameters:
        - searchMethod: The artist search method, either by name or by MusicBrainz ID.
        - autoCorrect: Whether to transform misspelled artist names into correct artist names. The default value is `true`.

     - Returns: An array of ``SBKTag`` objects representing the top tags for the specified artist.

     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if the operation fails.

     - Note: See [Last.fm's artist.getTopTags documentation](https://www.last.fm/api/show/artist.getTopTags) for more information.
     */
    func getTopTags(
        forArtist searchMethod: SBKArtistSearchMethod,
        autoCorrect: Bool = true
    ) async throws -> [SBKTag] {
        let service = ArtistGetTopTagsService(
            searchMethod: searchMethod,
            autoCorrect: autoCorrect,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        guard let tags = response.toptags.tag else {
            return []
        }
        return tags
    }
}
