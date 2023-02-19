//
//  SBKAlbumSearchMethod.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

public enum SBKAlbumSearchMethod {
    case albumArtist(album: String, artist: String)
    case musicBrainzID(id: String)
}
