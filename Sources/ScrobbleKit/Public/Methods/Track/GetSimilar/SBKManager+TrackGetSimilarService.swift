//
//  SBKManager+TrackGetSimilarService.swift
//  
//
//  Created by Tomas Martins on 14/06/23.
//

import Foundation

public extension SBKManager {
    /**
     Retrieves a list of tracks similar to the given track and artist.
     
     - Parameters:
     - track: The search method for the track. It can be either the track name and artist name, or a MusicBrainz ID.
     - autoCorrect: Transform misspelled track or artist names into correct names, returning the correct version instead. The default value is `true`.
     - limit: The maximum number of similar tracks to retrieve. Pass `nil` to use the default limit.
     - completion: A closure to be executed when the request is complete. It returns an array of ``SBKTrack`` objects representing the similar tracks and an optional error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/track.getSimilar).
     */
    func getSimilarTracks(
        _ track: SBKTrackSearchMethod,
        autoCorrect: Bool = true,
        limit: Int? = nil,
        completion: (([SBKTrack]?, Error?) -> Void)?
    ) {
        let service = TrackGetSimilarService(
            track: track,
            autoCorrect: autoCorrect,
            limit: limit,
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
            
            var tracks: [SBKTrack] = []
            for similarTrack in response.similarTracks.tracks {
                tracks.append(.init(similarTrack: similarTrack))
            }
            
            completion?(tracks, nil)
        }
    }
    
    /**
     Retrieves a list of tracks similar to the given track and artist.
     
     - Parameters:
     - track: The search method for the track. It can be either the track name and artist name, or a MusicBrainz ID.
     - autoCorrect: Transform misspelled track or artist names into correct names, returning the correct version instead. The default value is `true`.
     - limit: The maximum number of similar tracks to retrieve. Pass `nil` to use the default limit.
     
     - Returns: an array of ``SBKTrack`` objects  representing the similar tracks.
     
     - Throws: An error of type ``SBKClientError`` or ``SBKError`` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/track.getSimilar).
     */
    func getSimilarTracks(
        _ track: SBKTrackSearchMethod,
        autoCorrect: Bool = true,
        limit: Int? = nil
    ) async throws -> [SBKTrack] {
        let service = TrackGetSimilarService(
            track: track,
            autoCorrect: autoCorrect,
            limit: limit,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        
        var tracks: [SBKTrack] = []
        for similarTrack in response.similarTracks.tracks {
            tracks.append(.init(similarTrack: similarTrack))
        }
        
        return tracks
    }
}
