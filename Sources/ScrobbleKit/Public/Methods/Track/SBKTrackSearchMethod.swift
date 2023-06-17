//
//  SBKTrackSearchMethod.swift
//  
//
//  Created by Tomas Martins on 14/06/23.
//

import Foundation

public enum SBKTrackSearchMethod {
    case trackInfo(_ title: String, artist: String)
    case musicBrainzID(_ id: String)
}
