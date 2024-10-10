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
        page: Int = 1
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
    
    /**
     Retrieves the top artists for a specific geographic location.
     
     - Parameters:
     - country: The two-letter country code for the desired location.
     - limit: The maximum number of results to return (default value is 50).
     - completion: A closure to be executed when the request is complete. It returns an optional array of ``SBKArtist`` objects representing the search results and an optional error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/geo.getTopArtists).
     */
    @available(swift, deprecated: 5.10, obsoleted: 6.0, message: "Completion handler APIs will be removed in a future version; please migrate to the async version of this method")
    func getTopArtists(
        forCountry country: SBKCountry,
        limit: Int = 50,
        page: Int = 1,
        completion: (([SBKArtist]?, Error?) -> Void)?
    ) {
        let service = GeoGetTopArtistsService(
            country: country,
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
            guard let response = response else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(response.topartists.artist, nil)
        }
    }
}
