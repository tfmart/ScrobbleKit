//
//  SBKLibraryGetArtistsResponse.swift
//  
//
//  Created by Tomas Martins on 24/02/23.
//

import Foundation

struct SBKLibraryGetArtistsResponse: Decodable, Sendable {
    let artists: SBKLibraryGetArtistsList
}

struct SBKLibraryGetArtistsList: Decodable, Sendable {
    let artist: [SBKArtist]
}

