//
//  SBKTrackSearchResultListResponse.swift
//  
//
//  Created by Tomas Martins on 15/06/23.
//

import Foundation

struct SBKTrackSearchResultListResponse: Decodable, Sendable {
    var track: [SBKTrack]?

    private enum CodingKeys: CodingKey {
        case track
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.track = try container.decodeOneOrManyIfPresent(SBKTrack.self, forKey: .track)
    }
}
