//
//  SBKTrackToScrobble.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

/// Represents a track to be scrobbled to Last.fm.
public struct SBKTrackToScrobble {
    /// The artist name.
    public let artist: String
    /// The track name.
    public let track: String
    /// The time the track started playing, in UTC.
    public let timestamp: Date
    /// The album name (optional).
    public let album: String?
    /// The album artist - if this differs from the track artist (optional).
    public let albumArtist: String?
    /// The track number of the track on the album (optional).
    public let trackNumber: Int?
    /// The length of the track in seconds (optional).
    public let duration: Int?
    /// Whether the user chose this song (optional). If not specified, assumes the user chose the song.
    public let chosenByUser: Bool?
    /// The MusicBrainz Track ID (optional).
    public let mbid: String?

    /// Initializes a new track to be scrobbled.
    /// - Parameters:
    ///   - artist: The artist name.
    ///   - track: The track name.
    ///   - timestamp: The time the track started playing, in UTC.
    ///   - album: The album name (optional).
    ///   - albumArtist: The album artist, if different from the track artist (optional).
    ///   - trackNumber: The track number on the album (optional).
    ///   - duration: The length of the track in seconds (optional).
    ///   - chosenByUser: Whether the user chose this song (optional).
    ///   - mbid: The MusicBrainz Track ID (optional).
    public init(
        artist: String,
        track: String,
        timestamp: Date = Date(),
        album: String? = nil,
        albumArtist: String? = nil,
        trackNumber: Int? = nil,
        duration: Int? = nil,
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
        self.chosenByUser = chosenByUser
        self.mbid = mbid
    }
}

extension SBKTrackToScrobble: Equatable, Hashable {
    public static func == (lhs: SBKTrackToScrobble, rhs: SBKTrackToScrobble) -> Bool {
        return lhs.artist == rhs.artist &&
               lhs.track == rhs.track &&
               lhs.timestamp == rhs.timestamp
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(artist)
        hasher.combine(track)
        hasher.combine(timestamp)
    }
}
