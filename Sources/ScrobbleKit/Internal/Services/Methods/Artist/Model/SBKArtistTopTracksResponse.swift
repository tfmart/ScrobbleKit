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

    private enum CodingKeys: CodingKey {
        case track
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.track = try container.decodeOneOrMany(SBKTrack.self, forKey: .track)
    }
}
