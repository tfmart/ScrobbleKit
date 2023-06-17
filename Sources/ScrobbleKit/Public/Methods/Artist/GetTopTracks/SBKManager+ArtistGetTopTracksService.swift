//
//  SBKManager+ArtistGetTopTracksService.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation


extension SBKManager {
    /**
     Gets the top tracks by an artist.
     
     - Parameters:
     - artist: The name of the artist.
     - limit: The number of tracks to return.
     - page: The page number to fetch.
     
     - Returns: An array of ``SBKTrack`` objects representing the artist's top tracks.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/artist.getTopTracks).
     */
    func getArtistTopTracks(
        _ searchMethod: SBKArtistSearchMethod,
        limit: Int = 50,
        page: Int = 1,
        autoCorrect: Bool = true
    ) async throws -> [SBKTrack] {
        let service = ArtistGetTopTracksService(
            searchMethod,
            limit: limit,
            page: page,
            autoCorrect: autoCorrect,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        return response.toptracks.track
    }
    
    /**
     Gets the top tracks by an artist.
     
     - Parameters:
     - artist: The name of the artist.
     - limit: The number of tracks to return.
     - page: The page number to fetch.
     - completion: A closure to be executed when the search is complete. It returns an optional array of ``SBKTrack`` objects representing the artist's top tracks and an optional error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/artist.getTopTracks).
     */
    func getArtistTopTracks(
        _ searchMethod: SBKArtistSearchMethod,
        limit: Int = 50,
        page: Int = 1,
        autoCorrect: Bool = true,
        _ completion: (([SBKTrack]?, Error?) -> Void)?
    ) {
        let service = ArtistGetTopTracksService(
            searchMethod,
            limit: limit,
            page: page,
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
            completion?(response?.toptracks.track, nil)
        }
    }
}
