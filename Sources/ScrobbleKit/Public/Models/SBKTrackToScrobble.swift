//
//  SBKTrackToScrobble.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

public struct SBKTrackToScrobble {
    public let artist: String
    public let track: String
    public let timestamp: Date
    public let album: String?
    public let albumArtist: String?
    public let trackNumber: Int?
    public let duration: Int?
    public let streamId: String?
    public let chosenByUser: Bool?
    public let mbid: String?

    public init(
        artist: String,
        track: String,
        timestamp: Date,
        album: String? = nil,
        albumArtist: String? = nil,
        trackNumber: Int? = nil,
        duration: Int? = nil,
        streamId: String? = nil,
        chosenByUser: Bool? = nil,
        mbid: String? = nil
    ) {
        self.artist = artist
        self.track = track
        self.timestamp = timestamp
        self.album = album
        self.albumArtist = albumArtist
        self.trackNumber = trackNumber
        self.duration = duration
        self.streamId = streamId
        self.chosenByUser = chosenByUser
        self.mbid = mbid
    }
}
