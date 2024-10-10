//
//  SBKManager+TrackGetTopTagsService.swift
//  
//
//  Created by Tomas Martins on 14/06/23.
//

import Foundation

public extension SBKManager {
    /**
     Retrieves the top tags for a given track.
     
     - Parameters:
     - searchMethod: The search method for the track. It can be either the track name and artist name or a MusicBrainz ID.
     - autoCorrect: Transform misspelled track or artist names into correct names, returning the correct version instead. The default value is `true`.
     - completion: A closure to be executed when the request is complete. It returns an optional `SBKChartGetTopTagsResponse` object representing the top tags and an optional error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/track.getTopTags).
     */
    @available(swift, deprecated: 5.10, obsoleted: 6.0, message: "Completion handler APIs will be removed in a future version; please migrate to the async version of this method")
    func getTopTagsForTrack(
        searchMethod: SBKTrackSearchMethod,
        autoCorrect: Bool = true,
        completion: (([SBKTag]?, Error?) -> Void)?
    ) {
        let service = TrackGetTopTagsService(
            searchMethod: searchMethod,
            autoCorrect: autoCorrect,
            apiKey: apiKey,
            secretKey: secret
        )
        
        service.start { (response, error) in
            guard let response else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            
            completion?(response.toptags.tag, nil)
        }
    }
    
    
    /**
     Retrieves the top tags for a given track.
     
     - Parameters:
     - searchMethod: The search method for the track. It can be either the track name and artist name or a MusicBrainz ID.
     - autoCorrect: Transform misspelled track or artist names into correct names, returning the correct version instead. The default value is `true`.
     
     - Returns: An optional `SBKChartGetTopTagsResponse` object representing the top tags associated with the track.
     
     - Throws: An error of type `SBKClientError` or `SBKError` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/track.getTopTags).
     */
    func getTopTagsForTrack(
        searchMethod: SBKTrackSearchMethod,
        autoCorrect: Bool = true
    ) async throws -> [SBKTag] {
        let service = TrackGetTopTagsService(
            searchMethod: searchMethod,
            autoCorrect: autoCorrect,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        guard let tags = response.toptags.tag else {
            return []
        }
        return tags
    }
}
