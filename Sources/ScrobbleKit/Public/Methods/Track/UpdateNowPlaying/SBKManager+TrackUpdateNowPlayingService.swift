//
//  SBKManager+TrackUpdateNowPlayingService.swift
//  
//
//  Created by Tomas Martins on 11/06/23.
//

import Foundation

public extension SBKManager {
    /**
     Notifies Last.fm that a user has started listening to a track.
     
     - Parameters:
     - artist: The artist name. (Required)
     - track: The track name. (Required)
     - album: The album name. (Optional)
     - trackNumber: The track number of the track on the album. (Optional)
     - context: Sub-client version. (Optional)
     - mbid: The MusicBrainz Track ID. (Optional)
     - duration: The length of the track in seconds. (Optional)
     - albumArtist: The album artist, if different from the track artist. (Optional)
     - completion: A closure to be executed when the request is complete. It returns a `SBKNowPlayingCorrected` instance or an error.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/track.updateNowPlaying).
     */
    @available(swift, deprecated: 5.10, obsoleted: 6.0, message: "Completion handler APIs will be removed in a future version; please migrate to the async version of this method")
    func updateNowPlaying(
        artist: String,
        track: String,
        album: String? = nil,
        trackNumber: Int? = nil,
        context: String? = nil,
        mbid: String? = nil,
        duration: Int? = nil,
        albumArtist: String? = nil,
        completion: ((SBKNowPlayingCorrected?, Error?) -> Void)? = nil
    ) {
        guard let sessionKey else {
            completion?(nil, SBKClientError.missingSessionKey)
            return
        }
        
        let service = TrackUpdateNowPlayingService(
            artist: artist,
            track: track,
            album: album,
            trackNumber: trackNumber,
            context: context,
            mbid: mbid,
            duration: duration,
            albumArtist: albumArtist,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
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
            
            let correctedInfo = SBKNowPlayingCorrected(response: response)
            completion?(correctedInfo, nil)
        }
    }
    
    /**
     Notifies Last.fm that a user has started listening to a track.
     
     - Parameters:
     - artist: The artist name. (Required)
     - track: The track name. (Required)
     - album: The album name. (Optional)
     - trackNumber: The track number of the track on the album. (Optional)
     - context: Sub-client version. (Optional)
     - mbid: The MusicBrainz Track ID. (Optional)
     - duration: The length of the track in seconds. (Optional)
     - albumArtist: The album artist, if different from the track artist. (Optional)
     
     - Throws: An error of type `SBKClientError` or `SBKError` if there is an issue with the API request or decoding the response.
     
     - Note: For more information, see the [Last.fm API documentation](https://www.last.fm/api/show/track.updateNowPlaying).
     */
    func updateNowPlaying(
        artist: String,
        track: String,
        album: String? = nil,
        trackNumber: Int? = nil,
        context: String? = nil,
        mbid: String? = nil,
        duration: Int? = nil,
        albumArtist: String? = nil
    ) async throws -> SBKNowPlayingCorrected {
        guard let sessionKey else { throw SBKClientError.missingSessionKey }
        
        let service = TrackUpdateNowPlayingService(
            artist: artist,
            track: track,
            album: album,
            trackNumber: trackNumber,
            context: context,
            mbid: mbid,
            duration: duration,
            albumArtist: albumArtist,
            apiKey: apiKey,
            secretKey: secret,
            sessionKey: sessionKey
        )
        let response = try await service.start()
        return SBKNowPlayingCorrected(response: response)
    }
}
