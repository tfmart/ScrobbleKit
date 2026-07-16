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

    private enum CodingKeys: CodingKey {
        case artist
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.artist = try container.decodeOneOrMany(SBKArtist.self, forKey: .artist)
    }
}
