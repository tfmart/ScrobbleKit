//
//  SBKUserTagsResponse.swift
//  
//
//  Created by Tomas Martins on 17/06/23.
//

import Foundation

struct SBKUserTagsResponse: Decodable, Sendable {
    var taggings: SBKUserTagsList
}

struct SBKUserTagsList: Decodable, Sendable {
    var tracks: SBKUserTagsListResults?
    var albums: SBKUserTagsListResults?
    var artists: SBKUserTagsListResults?
    var attributes: SBKUserPersonalTagsAttributes
    
    enum CodingKeys: String, CodingKey {
        case tracks, albums, artists
        case attributes = "@attr"
    }
}

struct SBKUserTagsListResults: Decodable, Sendable {
    var track: [SBKTrack]?
    var album: [SBKAlbum]?
    var artist: [SBKArtist]?

    private enum CodingKeys: CodingKey {
        case track
        case album
        case artist
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.track = try container.decodeOneOrManyIfPresent(SBKTrack.self, forKey: .track)
        self.album = try container.decodeOneOrManyIfPresent(SBKAlbum.self, forKey: .album)
        self.artist = try container.decodeOneOrManyIfPresent(SBKArtist.self, forKey: .artist)
    }
}
