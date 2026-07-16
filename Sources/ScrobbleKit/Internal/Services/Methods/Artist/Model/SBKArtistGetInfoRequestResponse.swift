//
//  SBKArtistGetInfoRequestResponse.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

struct SBKArtistGetInfoRequestResponse: Decodable, Sendable {
    var artist: SBKArtistGetInfoProperties
}

struct SBKArtistGetInfoProperties: Decodable, Sendable {
    var name: String
    var mbid: String?
    var image: [SBKImageResponse]?
    var url: String
    var streamable: String?
    var ontour: String?
    var stats: SBKArtistGetInfoPropertiesStats?
    var similar: SBKArtistGetInfoSimilarResponse?
    var tags: SBKTagRequestResponseList?
    var bio: SBKWiki?
}

struct SBKArtistGetInfoPropertiesStats: Decodable, Sendable {
    var listeners: String
    var playcount: String
}

struct SBKArtistGetInfoSimilarResponse: Decodable, Sendable {
    var artist: [SBKArtistGetInfoSimilarArtist]

    private enum CodingKeys: CodingKey {
        case artist
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.artist = try container.decodeOneOrMany(SBKArtistGetInfoSimilarArtist.self, forKey: .artist)
    }
    
    var sbkArtist: [SBKArtist] {
        return artist.map { SBKArtist(similarArtist: $0) }
    }
}
