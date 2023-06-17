//
//  SBKArtistGetTopAlbumsResponse.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

struct SBKArtistGetTopAlbumsResponse: Decodable {
    let topAlbums: SBKArtistGetTopAlbumsList
    
    enum CodingKeys: String, CodingKey {
        case topAlbums = "topalbums"
    }
}

struct SBKArtistGetTopAlbumsList: Decodable {
    let albums: [SBKArtistTopAlbum]
    
    enum CodingKeys: String, CodingKey {
        case albums = "album"
    }
}

struct SBKArtistTopAlbum: Decodable {
    var name: String
    var url: String
    var playcount: Int
    var mbid: String?
    var image: [SBKImageResponse]
    var artist: SBKArtistTopAlbumArtist
}

struct SBKArtistTopAlbumArtist: Decodable {
    var name: String
    var mbid: String?
    var url: String
}
