//
//  SBKGeoTopArtistsResponse.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

struct SBKGeoTopArtistsResponse: Decodable {
    var topartists: SBKGeoTopArtistsList
}

struct SBKGeoTopArtistsList: Decodable {
    let artist: [SBKArtist]
}
