//
//  SBKLibraryGetArtistsResponse.swift
//  
//
//  Created by Tomas Martins on 24/02/23.
//

import Foundation

struct SBKLibraryGetArtistsResponse: Decodable {
    let artists: SBKLibraryGetArtistsList
}

struct SBKLibraryGetArtistsList: Decodable {
    let artist: [SBKArtist]
}

