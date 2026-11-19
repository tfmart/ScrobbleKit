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
    let attributes: SBKPaginationAttributes?

    private enum CodingKeys: String, CodingKey {
        case track
        case attributes = "@attr"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.track = try container.decodeOneOrMany(SBKTrack.self, forKey: .track)
        self.attributes = try? container.decodeIfPresent(SBKPaginationAttributes.self, forKey: .attributes)
    }
}
