//
//  SBKManager+GeoGetTopTracksService.swift
//  
//
//  Created by Tomas Martins on 24/02/23.
//

import Foundation

public extension SBKManager {
    /**
     Get the most popular tracks on Last.fm by country.
     
     - Parameters:
        - country: A country name, as defined by the ISO 3166-1 country names standard.
        - limit: The number of results to fetch per page. Defaults to 50.
        - page: The page number to fetch. Defaults to 1.
     
     - Returns: An ``SBKSearchResult`` containing the top tracks and pagination metadata reported by Last.fm.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/geo.getTopTracks).
     */
    func getTopTracks(
        forCountry country: SBKCountry,
        limit: Int = .sbkLimitPerPage,
        page: Int = .sbkFirstPage
    ) async throws -> SBKSearchResult<SBKTrack> {
        let service = GeoGetTopTracksService(
            country: country,
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        guard let attributes = response.tracks.attributes else {
            throw SBKClientError.failedToDecodeResponse
        }
        let pagination = try SBKPagination(attributes: attributes)
        return .init(
            results: response.tracks.track,
            searchTerms: [:],
            pagination: pagination
        )
    }
}
