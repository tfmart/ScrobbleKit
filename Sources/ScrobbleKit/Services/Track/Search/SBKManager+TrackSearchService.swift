//
//  SBKManager+TrackSearchService.swift
//  
//
//  Created by Tomas Martins on 15/06/23.
//

import Foundation

public extension SBKManager {
    /**
     Search for tracks matching the given query.
     
     - Parameters:
       - track: The track name to search for.
       - artist: The artist name to search for.
       - limit: The maximum number of results to return (default: 30).
       - page: The page number of results to return (default: 0).
     
     - Returns: An array of ``SBKTrack`` objects representing the search results.
     
     - Throws: An error of type `SBKClientError` or `SBKError` if the operation fails.
     
     - Note: See [Last.fm's track.search documentation](https://www.last.fm/api/show/track.search) for more information.
     */
    func searchTracks(track: String, artist: String, limit: Int = 30, page: Int = 0) async throws -> [SBKTrack] {
        let service = TrackSearchService(
            track: track,
            artist: artist,
            limit: limit,
            page: page,
            apiKey: apiKey,
            secretKey: secret
        )
        
        let response = try await service.start()
        let tracks = response.results.matches.track ?? []
        return tracks
    }
    
    /**
     Search for tracks matching the given query.
     
     - Parameters:
       - track: The track name to search for.
       - artist: The artist name to search for.
       - limit: The maximum number of results to return (default: 30).
       - page: The page number of results to return (default: 0).
       - completion: A closure to be executed when the search is complete. It returns an optional array of ``SBKTrack`` objects representing the search results and an optional error.
     
     - Note: See [Last.fm's track.search documentation](https://www.last.fm/api/show/track.search) for more information.
     */
    func searchTracks(track: String, artist: String, limit: Int = 30, page: Int = 0, completion: (([SBKTrack]?, Error?) -> Void)?) {
        let service = TrackSearchService(
            track: track,
            artist: artist,
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
            guard response != nil else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(response?.results.matches.track, nil)
        }
    }
}
