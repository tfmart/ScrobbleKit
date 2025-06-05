//
//  SBKGeoTopArtistsResponse.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

struct SBKGeoTopArtistsResponse: Decodable, Sendable {
    var topartists: SBKGeoTopArtistsList
}

struct SBKGeoTopArtistsList: Decodable, Sendable {
    let artist: [SBKArtist]
}
