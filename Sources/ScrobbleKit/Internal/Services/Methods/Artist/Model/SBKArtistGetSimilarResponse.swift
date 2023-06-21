//
//  SBKArtistGetSimilarResponse.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

struct SBKArtistGetSimilarResponse: Decodable {
    var similarartists: SBKArtistGetSimilarList
}

struct SBKArtistGetSimilarList: Decodable {
    var artist: [SBKSimilarArtist]
}
