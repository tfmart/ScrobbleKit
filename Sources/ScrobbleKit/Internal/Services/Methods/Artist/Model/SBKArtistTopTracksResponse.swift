//
//  SBKArtistTopTracksResponse.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

struct SBKArtistTopTracksResponse: Decodable, Sendable {
    var toptracks: SBKArtistTopTracksList
}

struct SBKArtistTopTracksList: Decodable, Sendable {
    var track: [SBKTrack]
}
