//
//  SBKManager+TrackGetInfoService.swift.swift
//  
//
//  Created by Tomas Martins on 26/04/23.
//

import Foundation

public extension SBKManager {
    /**
     Retrieves the metadata for a track on Last.fm.
     
     - Parameters:
        - track: The name of the track to retrieve metadata for.
        - artist: The name of the artist of the track.
        - username: (Optional) The username for the context of the request. Defaults to `nil`.
        - autoCorrect: (Optional) Whether to automatically correct misspelled artist/track names. Defaults to `false`.
        - languageCode: (Optional) The ISO 639-1 language code for the language to return the biography in. Defaults to `.english`.
        - completion: A closure to be executed when the request is complete. It returns an optional `SBKTrack` object representing the track metadata and an optional error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/track.getInfo).
     */
    func getTrackInfo(
        track: String,
        artist: String,
        username: String? = nil,
        autoCorrect: Bool = false,
        _ completion: ((SBKTrack?, Error?) -> Void)?
    ) {
        let service = TrackGetInfoService(track: track, artist: artist, username: username, autoCorrect: autoCorrect, apiKey: apiKey, secretKey: secret)
        service.start { response, error in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard let response = response else {
                completion?(nil, SBKClientError.failedToDecodeResponse)
                return
            }
            let track = response.track
            completion?(track, nil)
        }
    }
    
    /**
     Retrieves the metadata for a track on Last.fm.
     
     - Parameters:
        - track: The name of the track to retrieve metadata for.
        - artist: The name of the artist of the track.
        - username: (Optional) The username for the context of the request. Defaults to `nil`.
        - autoCorrect: (Optional) Whether to automatically correct misspelled artist/track names. Defaults to `false`.
        - languageCode: (Optional) The ISO 639-1 language code for the language to return the biography in. Defaults to `.english`.
     
     - Returns: A `SBKTrack` object representing the track metadata.
     
     - Throws: An error of type `SBKClientError` or `SBKError` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/track.getInfo).
     */
    func getTrackInfo(
        track: String,
        artist: String,
        username: String? = nil,
        autoCorrect: Bool = false,
        languageCode: SBKLanguageCode = .english
    ) async throws -> SBKTrack {
        let service = TrackGetInfoService(track: track, artist: artist, username: username, autoCorrect: autoCorrect, apiKey: apiKey, secretKey: secret)
        let response = try await service.start()
        let track = response.track
        return track
    }
}
