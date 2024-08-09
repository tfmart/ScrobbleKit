//
//  SBKArtistSearchMethod.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

/// Represents the different methods available for searching an artist on Last.fm.
public enum SBKArtistSearchMethod {
    /// Search for an artist by their name.
    ///
    /// - Parameter artist: The name of the artist to search for.
    case artistName(_ artist: String)
    
    /// Search for an artist by their MusicBrainz ID.
    ///
    /// - Parameter id: The MusicBrainz ID of the artist.
    case musicBrainzID(_ id: String)
}
