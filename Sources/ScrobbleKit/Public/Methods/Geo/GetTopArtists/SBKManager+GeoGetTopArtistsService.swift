//
//  SBKManager+GeoGetTopArtistsService.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

public extension SBKManager {
    /**
     Fetches the top artists for a given country or metro area.
     
     - Parameters:
     - location: The location for which to fetch the top artists.
     - limit: The maximum number of results to return. Defaults to 50.
     - page: The page number of results to return. Defaults to 1.
     
     - Returns: An array of `SBKArtist` objects representing the top artists for the given location.
     
     - Throws: An error of type `SBKClientError` or `SBKError` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/geo.getTopArtists).
     */
    func getTopArtists(
        forCountry country: SBKCountry,
        limit: Int = 50,
        page: Int = .sbkFirstPage
    ) async throws -> [SBKArtist] {
        let service = GeoGetTopArtistsService(
            country: country,
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        return response.topartists.artist
    }
}
