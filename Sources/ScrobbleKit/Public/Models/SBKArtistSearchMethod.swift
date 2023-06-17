//
//  SBKArtistSearchMethod.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

public enum SBKArtistSearchMethod {
    case artistName(_ artist: String)
    case musicBrainzID(_ id: String)
}
