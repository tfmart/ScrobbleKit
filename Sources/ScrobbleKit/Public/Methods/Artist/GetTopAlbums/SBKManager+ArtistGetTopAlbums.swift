//
//  SBKManager+ArtistGetTopAlbums.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

public extension SBKManager {
    /**
     Gets the top albums for the specified artist.
     
     - Parameters:
     - searchMethod: The search method to use to find the artist. Either by name or MusicBrainz ID.
     - limit: The maximum number of albums to return. Default is 50.
     - page: The page of results to return. Default is 1.
     
     - Returns: An ``SBKSearchResult`` containing the artist's top albums and pagination metadata reported by Last.fm.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/artist.getTopAlbums).
     */
    func getTopAlbums(
        forArtist searchMethod: SBKArtistSearchMethod,
        limit: Int = .sbkLimitPerPage,
        page: Int = .sbkFirstPage,
        autoCorrect: Bool = true
    ) async throws -> SBKSearchResult<SBKAlbum> {
        let service = ArtistGetTopAlbumsService(
            searchMethod,
            limit: limit,
            page: page,
            autoCorrect: autoCorrect,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        guard let attributes = response.topAlbums.attributes else {
            throw SBKClientError.failedToDecodeResponse
        }
        let pagination = try SBKPagination(attributes: attributes)
        return .init(
            results: response.topAlbums.albums.map { SBKAlbum(topAlbumArtist: $0) },
            searchTerms: [.artist: searchMethod.searchTerm],
            pagination: pagination
        )
    }
}
