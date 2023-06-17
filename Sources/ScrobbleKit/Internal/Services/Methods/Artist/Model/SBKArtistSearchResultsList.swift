//
//  SBKArtistSearchResultsList.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

struct SBKArtistSearchResultsList: Decodable {
    let artists: [SBKArtist]
    
    private enum CodingKeys: String, CodingKey {
        case artists = "artist"
    }
}
