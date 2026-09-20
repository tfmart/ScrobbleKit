//
//  SBKArtistTopChartsRequestResponse.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

struct SBKArtistTopChartsRequestResponse: Decodable, Sendable {
    let artists: SBKArtistListResponse
}

struct SBKArtistListResponse: Decodable, Sendable {
    let artists: [SBKArtist]
    let attributes: SBKPaginationAttributes?
    
    enum CodingKeys: String, CodingKey {
        case artists = "artist"
        case attributes = "@attr"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.artists = try container.decodeOneOrMany(SBKArtist.self, forKey: .artists)
        self.attributes = try? container.decodeIfPresent(SBKPaginationAttributes.self, forKey: .attributes)
    }
}
