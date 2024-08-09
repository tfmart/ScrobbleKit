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
     
     - Returns: An array of ``SBKTrack`` objects representing the top tracks for the specified country.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/geo.getTopTracks).
     */
    func getTopTracks(
        forCountry country: SBKCountry,
        limit: Int = 50,
        page: Int = 1
    ) async throws -> [SBKTrack] {
        let service = GeoGetTopTracksService(
            country: country,
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        return response.tracks.track
    }
    
    /**
     Get the most popular tracks on Last.fm by country.
     
     - Parameters:
        - country: A country name, as defined by the ISO 3166-1 country names standard.
        - limit: The number of results to fetch per page. Defaults to 50.
        - page: The page number to fetch. Defaults to 1.
        - completion: A closure to be executed when the request is complete. It returns an optional array of ``SBKTrack`` objects representing the top tracks for the specified country, and an optional error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/geo.getTopTracks).
     */
    func getTopTracks(
        forCountry country: SBKCountry,
        limit: Int = 50,
        page: Int = 1,
        completion: (([SBKTrack]?, Error?) -> Void)?
    ) {
        let service = GeoGetTopTracksService(
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
            completion?(response.tracks.track, nil)
        }
    }
}
