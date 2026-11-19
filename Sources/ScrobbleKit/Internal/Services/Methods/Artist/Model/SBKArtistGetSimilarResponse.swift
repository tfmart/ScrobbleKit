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

    private enum CodingKeys: CodingKey {
        case artist
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.artist = try container.decodeOneOrMany(SBKSimilarArtist.self, forKey: .artist)
    }
}
