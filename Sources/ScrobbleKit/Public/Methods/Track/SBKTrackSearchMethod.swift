//
//  SBKTrackSearchMethod.swift
//  
//
//  Created by Tomas Martins on 14/06/23.
//

import Foundation

/// Represents the different methods available for searching a track on Last.fm.
public enum SBKTrackSearchMethod {
    /// Search for a track by its name and artist.
    ///
    /// - Parameters:
    ///   - album: The name of the track to search for.
    ///   - artist: The name of the artist who created the track.
    case trackInfo(_ title: String, artist: String)
    /// Search for an track by their MusicBrainz ID.
    ///
    /// - Parameter id: The MusicBrainz ID of the track.
    case musicBrainzID(_ id: String)
}
