//
//  SBKManager+TagGetTopAlbums.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//


import Foundation

public extension SBKManager {
    /**
     Get the top albums tagged by this tag, ordered by tag count.
     
     - Parameters:
        - tag: The tag name.
        - limit: The number of results to fetch per page. Defaults to 50.
        - page: The page number to fetch. Defaults to first page.
     
     - Returns: An array of `SBKAlbum` representing the top albums.
     
     - Throws: An error of type `SBKError` if the request fails.
     
     - Note: See [Last.fm's tag.getTopAlbums documentation](https://www.last.fm/api/show/tag.getTopAlbums) for more information.
     */
    func getTopAlbums(forTag tag: String, limit: Int = 50, page: Int = 1) async throws -> [SBKAlbum] {
        let service = TagGetTopAlbumsService(tag: tag, limit: limit, page: page, apiKey: apiKey, secretKey: secret)
        let response = try await service.start()
        return response.albums
    }
}
