//
//  SBKArtistGetSimilarResponse.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

struct SBKArtistGetSimilarResponse: Decodable, Sendable {
    var similarartists: SBKArtistGetSimilarList
}

struct SBKArtistGetSimilarList: Decodable, Sendable {
    var artist: [SBKSimilarArtist]
}
