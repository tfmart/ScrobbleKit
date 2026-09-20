//
//  SBKManager+ArtistGetTopTracksService.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation


public extension SBKManager {
    /**
     Gets the top tracks by an artist.
     
     - Parameters:
     - artist: The name of the artist.
     - limit: The number of tracks to return.
     - page: The page number to fetch.
     
     - Returns: An ``SBKSearchResult`` containing the artist's top tracks and pagination metadata reported by Last.fm.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/artist.getTopTracks).
     */
    func getArtistTopTracks(
        _ searchMethod: SBKArtistSearchMethod,
        limit: Int = .sbkLimitPerPage,
        page: Int = .sbkFirstPage,
        autoCorrect: Bool = true
    ) async throws -> SBKSearchResult<SBKTrack> {
        let service = ArtistGetTopTracksService(
            searchMethod,
            limit: limit,
            page: page,
            autoCorrect: autoCorrect,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        guard let attributes = response.toptracks.attributes else {
            throw SBKClientError.failedToDecodeResponse
        }
        let pagination = try SBKPagination(attributes: attributes)
        return .init(
            results: response.toptracks.track,
            searchTerms: [.artist: searchMethod.searchTerm],
            pagination: pagination
        )
    }
}
