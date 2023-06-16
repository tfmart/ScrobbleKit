//
//  SBKScrobbleResponse.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

public struct SBKScrobbleResponse {
    public let tracks: [SBKScrobbleResponseTrack]
    public let scrobbledTracks: Int
    public let ingnoredTracks: Int
    
    internal init(list: SBKScrobbleList) {
        self.tracks = list.scrobbles.scrobbles.compactMap({ sbkScrobble in
            // Unwrap required values
            guard let title = sbkScrobble.track.text,
                  let artist = sbkScrobble.artist.text else {
                return nil
            }
            
            // Check status
            let status: SBKScrobbleResponseTrackStatus
            switch sbkScrobble.ignoredMessage.code {
            case "0":
                status = .accepted
            default:
                status = .ignored(message: sbkScrobble.ignoredMessage.text)
            }
            
            // Check corrected attributes
            var correctedAttrs = [SBKScrobbleResponseAttribute]()
            if sbkScrobble.artist.corrected == "0" {
                correctedAttrs.append(.artist)
            }
            if sbkScrobble.track.corrected == "0" {
                correctedAttrs.append(.title)
            }
            if sbkScrobble.album.corrected == "0" {
                correctedAttrs.append(.album)
            }
            if sbkScrobble.albumArtist.corrected == "0" {
                correctedAttrs.append(.albumArtist)
            }
            
            // Return track object
            return SBKScrobbleResponseTrack(
                artist: artist,
                title: title,
                album: sbkScrobble.album.text,
                timestamp: sbkScrobble.timestamp,
                correctedAttributes: correctedAttrs,
                status: status
            )
        })
        self.scrobbledTracks = list.scrobbles.attr.accepted
        self.ingnoredTracks = list.scrobbles.attr.ignored
    }
}
