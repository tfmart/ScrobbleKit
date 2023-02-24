//
//  SBKManager+ArtistSearchService.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

public extension SBKManager {
    /**
     Searches for artists similar to the given query.
     
     - Parameters:
     - query: The search query.
     - limit: The maximum number of results to return.
     - page: The page number of results to return.
     
     - Returns: An array of ``SBKArtist`` objects representing the search results.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/artist.search).
     */
    func searchArtists(
        _ query: String,
        limit: Int = 50,
        page: Int = 1
    ) async throws -> [SBKArtist] {
        let service = ArtistSearchService(
            query,
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        return response.results.matches.artists
    }
    
    /**
     Searches for artists similar to the given query.
     
     - Parameters:
     - query: The search query.
     - limit: The maximum number of results to return.
     - page: The page number of results to return.
     - completion: A closure to be executed when the search is complete. It returns an optional array of ``SBKArtist`` objects representing the search results and an optional error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/artist.search).
     */
    func searchArtists(
        _ query: String,
        limit: Int = 50,
        page: Int = 1,
        _ completion: (([SBKArtist]?, Error?) -> Void)?
    ) {
        let service = ArtistSearchService(
            query,
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
            completion?(response.results.matches.artists, nil)
        }
    }
}
