//
//  SBKManager+ChartGetTopArtistsService.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

public extension SBKManager {
    /// Fetches the top artists chart from Last.fm.
    ///
    /// - Parameters:
    ///   - page: The page number to fetch. Defaults to first page.
    ///   - limit: The number of results to fetch per page. Defaults to 50.
    /// - Returns: An array of ``SBKArtist`` objects.
    /// - Throws: An error if the API call fails or the response cannot be decoded.
    ///
    /// See [Last.fm API documentation](https://www.last.fm/api/show/chart.getTopArtists) for more information.
    func getArtistsChart(
        page: Int = .sbkFirstPage,
        limit: Int = .sbkLimitPerPage
    ) async throws -> [SBKArtist] {
        let service = ChartGetTopArtistsService(
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        return response.artists.artists
    }
}
