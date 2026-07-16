//
//  SBKArtistGetTopAlbumsResponse.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

struct SBKArtistGetTopAlbumsResponse: Decodable, Sendable {
    let topAlbums: SBKArtistGetTopAlbumsList
    
    enum CodingKeys: String, CodingKey {
        case topAlbums = "topalbums"
    }
}

struct SBKArtistGetTopAlbumsList: Decodable, Sendable {
    let albums: [SBKArtistTopAlbum]
    
    enum CodingKeys: String, CodingKey {
        case albums = "album"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.albums = try container.decodeOneOrMany(SBKArtistTopAlbum.self, forKey: .albums)
    }
}

struct SBKArtistTopAlbum: Decodable, Sendable {
    var name: String
    var url: String
    var playcount: Int
    var mbid: String?
    var image: [SBKImageResponse]
    var artist: SBKArtistTopAlbumArtist
}

struct SBKArtistTopAlbumArtist: Decodable, Sendable {
    var name: String
    var mbid: String?
    var url: String
}
