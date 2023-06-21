//
//  SBKUserGetTopAlbumsResponse.swift
//  
//
//  Created by Tomas Martins on 20/06/23.
//

import Foundation

struct SBKUserGetTopAlbumsResponse: Decodable {
    let topAlbums: SBKUserGetTopAlbumsResult
    
    private enum CodingKeys: String, CodingKey {
        case topAlbums = "topalbums"
    }
}

struct SBKUserGetTopAlbumsResult: Decodable {
    let attributes: SBKUserGetTopAlbumsAttributes
    let albums: [SBKAlbum]
    
    private enum CodingKeys: String, CodingKey {
        case albums = "album"
        case attributes = "@attr"
    }
}

struct SBKUserGetTopAlbumsAttributes: SBKSearchAttribute {
    var user: String
    var page: String
    var perPage: String
    var totalPages: String
    var total: String
}

struct SBKUserGetTopArtistsResponse: Decodable {
    let topArtists: SBKUserGetTopArtistsResult
    
    private enum CodingKeys: String, CodingKey {
        case topArtists = "topartists"
    }
}

struct SBKUserGetTopArtistsResult: Decodable {
    let attributes: SBKUserGetTopAlbumsAttributes
    let artists: [SBKArtist]
    
    private enum CodingKeys: String, CodingKey {
        case artists = "artist"
        case attributes = "@attr"
    }
}

struct SBKUserGetTopTagsResponse: Decodable {
    let topTags: SBKUserGetTopTagsResult
    
    private enum CodingKeys: String, CodingKey {
        case topTags = "toptags"
    }
}

struct SBKUserGetTopTagsResult: Decodable {
    let attributes: SBKUserGetTopTagsAttribute
    let tags: [SBKTag]
    
    private enum CodingKeys: String, CodingKey {
        case tags = "tag"
        case attributes = "@attr"
    }
}

struct SBKUserGetTopTagsAttribute: Decodable {
    let user: String
}
