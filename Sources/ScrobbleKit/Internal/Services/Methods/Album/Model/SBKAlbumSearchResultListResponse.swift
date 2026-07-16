//
//  SBKAlbumSearchResultListResponse.swift
//  
//
//  Created by Tomas Martins on 26/04/23.
//

import Foundation

struct SBKAlbumSearchResultListResponse: Decodable, Sendable {
    var album: [SBKAlbum]?

    private enum CodingKeys: CodingKey {
        case album
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.album = try container.decodeOneOrManyIfPresent(SBKAlbum.self, forKey: .album)
    }
}
