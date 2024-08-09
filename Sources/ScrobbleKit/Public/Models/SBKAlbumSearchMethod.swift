//
//  SBKAlbumSearchMethod.swift
//
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

/// Represents the different methods available for searching an album on Last.fm.
public enum SBKAlbumSearchMethod {
    /// Search for an album by its name and artist.
    ///
    /// - Parameters:
    ///   - album: The name of the album to search for.
    ///   - artist: The name of the artist who created the album.
    case albumArtist(album: String, artist: String)
    
    /// Search for an album by its MusicBrainz ID.
    ///
    /// - Parameter id: The MusicBrainz ID of the album.
    case musicBrainzID(id: String)
}
