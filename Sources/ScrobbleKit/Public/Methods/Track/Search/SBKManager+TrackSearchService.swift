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
     
     - Returns: An ``SBKSearchResult`` containing the matching tracks and pagination metadata reported by Last.fm.
     
     - Throws: An error of type `SBKClientError` or `SBKError` if the operation fails.
     
     - Note: See [Last.fm's track.search documentation](https://www.last.fm/api/show/track.search) for more information.
     */
    func search(
        track: String,
        artist: String? = nil,
        limit: Int = 30,
        page: Int = .sbkFirstPage
    ) async throws -> SBKSearchResult<SBKTrack> {
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
        var searchTerms: [SBKSearchTerm: String] = [
            .track: response.results.query?.searchTerms ?? track
        ]
        if let artist {
            searchTerms[.artist] = artist
        }
        return try .init(results: tracks, searchTerms: searchTerms, response: response.results)
    }
}
