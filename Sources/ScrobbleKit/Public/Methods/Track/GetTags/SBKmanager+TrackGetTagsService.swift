//
//  SBKmanager+TrackGetTagsService.swift
//  
//
//  Created by Tomas Martins on 14/06/23.
//

import Foundation

public extension SBKManager {
    /**
     Retrieves a list of tags associated with a given track.
     
     - Parameters:
        - searchMethod: The search method for the track. It can be either the track name and artist name or a MusicBrainz ID.
        - autoCorrect: Transform misspelled track or artist names into correct names, returning the correct version instead. The default value is `true`.
        - username: The Last.fm username. If called in non-authenticated mode you must specify the user to look up
        - completion: A closure to be executed when the request is complete. It returns an optional `SBKTagRequestResponseList` object representing the list of tags and an optional error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/track.getTags).
     */
    func getTags(
        forTrack searchMethod: SBKTrackSearchMethod,
        autoCorrect: Bool = true,
        username: String? = nil,
        completion: (([SBKTag]?, Error?) -> Void)?
    ) {
        let service = TrackGetTagsService(
            searchMethod: searchMethod,
            autoCorrect: autoCorrect,
            username: username,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        service.start { (response, error) in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let response = response else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            completion?(response.tags.tag, nil)
        }
    }
    
    /**
     Retrieves a list of tags associated with a given track.
     
     - Parameters:
        - searchMethod: The search method for the track. It can be either the track name and artist name or a MusicBrainz ID.
        - autoCorrect: Transform misspelled track or artist names into correct names, returning the correct version instead. The default value is `true`.
        - username: The Last.fm username. If called in non-authenticated mode you must specify the user to look up
     
     - Returns: An array of `SBKTag` objects representing the tags associated with the track.
     
     - Throws: An error of type `SBKClientError` or `SBKError` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/track.getTags).
     */
    func getTags(
        forTrack searchMethod: SBKTrackSearchMethod,
        autoCorrect: Bool = true,
        username: String? = nil
    ) async throws -> [SBKTag] {
        let service = TrackGetTagsService(
            searchMethod: searchMethod,
            autoCorrect: autoCorrect,
            username: username,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        let response = try await service.start()
        guard let tags = response.tags.tag else {
            return []
        }
        return tags
    }
}
