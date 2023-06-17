//
//  SBKManager+ArtistGetSimilar.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

public extension SBKManager {
    /**
     Gets a list of similar artists for the given artist.
     
     - Parameters:
     - artist: The name of the artist to get similar artists for.
     - limit: The maximum number of similar artists to return.
     
     - Returns: An array of ``SBKArtist`` objects representing the similar artists.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/artist.getSimilar).
     */
    func getSimilarArtists(
        _ searchMethod: SBKArtistSearchMethod,
        limit: Int = 50,
        autoCorrect: Bool = true
    ) async throws -> [SBKSimilarArtist] {
        let service = ArtistGetSimilarService(
            searchMethod,
            limit: limit,
            autoCorrect: autoCorrect,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        return response.similarartists.artist
    }
    
    /**
     Gets a list of similar artists for the given artist.
     
     - Parameters:
     - artist: The name of the artist to get similar artists for.
     - limit: The maximum number of similar artists to return.
     - completion: A closure to be executed when the search is complete. It returns an optional array of ``SBKArtist`` objects representing the similar artists and an optional error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/artist.getSimilar).
     */
    func getSimilarArtists(
        _ searchMethod: SBKArtistSearchMethod,
        limit: Int = 50,
        autoCorrect: Bool = true,
        _ completion: (([SBKSimilarArtist]?, Error?) -> Void)?
    ) {
        let service = ArtistGetSimilarService(
            searchMethod,
            limit: limit,
            autoCorrect: autoCorrect,
            apiKey: apiKey,
            secretKey: secret
        )
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard response != nil else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(response?.similarartists.artist, nil)
        }
    }
}
