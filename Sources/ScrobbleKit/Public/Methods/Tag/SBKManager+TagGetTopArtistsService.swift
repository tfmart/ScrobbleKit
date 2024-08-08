//
//  SBKManager+TagGetTopArtistsService.swift
//
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

public extension SBKManager {
    /**
     Get the top artists tagged by this tag, ordered by tag count.
     
     - Parameters:
        - tag: The tag name.
        - limit: The number of results to fetch per page. Defaults to 50.
        - page: The page number to fetch. Defaults to first page.
     
     - Returns: An array of `SBKArtist` representing the top artists.
     
     - Throws: An error of type `SBKError` if the request fails.
     
     - Note: See [Last.fm's tag.getTopArtists documentation](https://www.last.fm/api/show/tag.getTopArtists) for more information.
     */
    func getTopArtists(forTag tag: String, limit: Int = 50, page: Int = 1) async throws -> [SBKArtist] {
        let service = TagGetTopArtistsService(tag: tag, limit: limit, page: page, apiKey: apiKey, secretKey: secret)
        let response = try await service.start()
        return response.artists
    }
}
