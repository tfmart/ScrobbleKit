//
//  SBKScrobbleResponseAttribute.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

/// Represents the fields of metadata of a song that may be corrected when attempting to scrobble it.
public enum SBKScrobbleResponseAttribute {
    /// The artist associated with the song
    case artist
    /// The title of the song
    case title
    /// The album associated with the song
    case album
    /// The artist of the album associated with the song
    case albumArtist
}
