//
//  SBKArtistTopTracksResponse.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

struct SBKArtistTopTracksResponse: Decodable {
    var toptracks: SBKArtistTopTracksList
}

struct SBKArtistTopTracksList: Decodable {
    var track: [SBKTrack]
}
