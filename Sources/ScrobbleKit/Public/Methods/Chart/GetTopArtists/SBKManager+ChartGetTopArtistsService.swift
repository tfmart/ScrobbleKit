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
    /// - Note: This method is asynchronous and should be called from within an `async` context.
    /// See [Last.fm API documentation](https://www.last.fm/api/show/chart.getTopArtists) for more information.
    func getArtistsChart(
        page: Int = 1,
        limit: Int = 50
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
    
    /// Fetches the top artists chart from Last.fm.
    ///
    /// - Parameters:
    ///   - page: The page number to fetch. Defaults to first page.
    ///   - limit: The number of results to fetch per page. Defaults to 50.
    ///   - completion: A closure to be called with the resulting array of ``SBKArtist`` objects or an error.
    ///
    /// - Note: See [Last.fm API documentation](https://www.last.fm/api/show/chart.getTopArtists) for more information.
    func getArtistsChart(
        page: Int = 1,
        limit: Int = 50,
        _ completion: (([SBKArtist]?, Error?) -> Void)?
    ) {
        let service = ChartGetTopArtistsService(
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let response else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(response.artists.artists, nil)
        }
    }
}
