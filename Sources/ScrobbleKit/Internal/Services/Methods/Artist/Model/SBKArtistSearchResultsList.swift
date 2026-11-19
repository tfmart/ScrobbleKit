//
//  SBKArtistSearchResultsList.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

struct SBKArtistSearchResultsList: Decodable, Sendable {
    let artists: [SBKArtist]
    
    private enum CodingKeys: String, CodingKey {
        case artists = "artist"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.artists = try container.decodeOneOrMany(SBKArtist.self, forKey: .artists)
    }
}
