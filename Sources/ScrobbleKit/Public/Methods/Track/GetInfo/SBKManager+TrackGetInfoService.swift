//
//  SBKManager+TrackGetInfoService.swift.swift
//  
//
//  Created by Tomas Martins on 26/04/23.
//

import Foundation

public extension SBKManager {
    /**
     Retrieves the metadata for a track on Last.fm using the track name and artist or a MusicBrainz ID.
     
     - Parameters:
        - searchMethod: The search method for the track. It can be either the track name and artist name or a MusicBrainz ID.
        - username: (Optional) The username for the context of the request. Defaults to `nil`.
        - autoCorrect: (Optional) Whether to automatically correct misspelled artist/track names. Defaults to `false`.
     
     - Returns: A `SBKTrack` object representing the track metadata.
     
     - Throws: An error of type `SBKClientError` or `SBKError` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/track.getInfo).
     */
    func getInfo(
        forTrack searchMethod: SBKTrackSearchMethod,
        username: String? = nil,
        autoCorrect: Bool = false
    ) async throws -> SBKTrack {
        let service = TrackGetInfoService(
            searchMethod: searchMethod,
            username: username,
            autoCorrect: autoCorrect,
            apiKey: apiKey,
            secretKey: secret
        )
        let response = try await service.start()
        let track = response.track
        return track
    }

    /**
     Retrieves the metadata for a track on Last.fm using the track name and artist.

     - Parameters:
        - track: The name of the track to retrieve metadata for.
        - artist: The name of the artist of the track.
        - username: (Optional) The username for the context of the request. Defaults to `nil`.
        - autoCorrect: (Optional) Whether to automatically correct misspelled artist/track names. Defaults to `false`.
        - languageCode: This endpoint does not support a language parameter. This argument is ignored.

     - Returns: A `SBKTrack` object representing the track metadata.
     */
    @available(*, deprecated, message: "Use getInfo(forTrack:username:autoCorrect:) with SBKTrackSearchMethod. Last.fm track.getInfo does not support a language parameter.")
    func getInfo(
        forTrack track: String,
        artist: String,
        username: String? = nil,
        autoCorrect: Bool = false,
        languageCode: SBKLanguageCode = .english
    ) async throws -> SBKTrack {
        try await getInfo(
            forTrack: .trackInfo(track, artist: artist),
            username: username,
            autoCorrect: autoCorrect
        )
    }
}
