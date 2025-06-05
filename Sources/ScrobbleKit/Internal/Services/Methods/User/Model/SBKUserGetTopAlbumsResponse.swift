//
//  SBKUserGetTopAlbumsResponse.swift
//  
//
//  Created by Tomas Martins on 20/06/23.
//

import Foundation

struct SBKUserGetTopAlbumsResponse: Decodable, Sendable {
    let topAlbums: SBKUserGetTopAlbumsResult
    
    private enum CodingKeys: String, CodingKey {
        case topAlbums = "topalbums"
    }
}

struct SBKUserGetTopAlbumsResult: Decodable, Sendable {
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

struct SBKUserGetTopArtistsResponse: Decodable, Sendable {
    let topArtists: SBKUserGetTopArtistsResult
    
    private enum CodingKeys: String, CodingKey {
        case topArtists = "topartists"
    }
}

struct SBKUserGetTopArtistsResult: Decodable, Sendable {
    let attributes: SBKUserGetTopAlbumsAttributes
    let artists: [SBKArtist]
    
    private enum CodingKeys: String, CodingKey {
        case artists = "artist"
        case attributes = "@attr"
    }
}

struct SBKUserGetTopTagsResponse: Decodable, Sendable {
    let topTags: SBKUserGetTopTagsResult
    
    private enum CodingKeys: String, CodingKey {
        case topTags = "toptags"
    }
}

struct SBKUserGetTopTagsResult: Decodable, Sendable {
    let attributes: SBKUserGetTopTagsAttribute
    let tags: [SBKTag]
    
    private enum CodingKeys: String, CodingKey {
        case tags = "tag"
        case attributes = "@attr"
    }
}

struct SBKUserGetTopTagsAttribute: Decodable, Sendable {
    let user: String
}

struct SBKUserGetTopTracksResponse: Decodable, Sendable {
    let topTracks: SBKUserGetTopTracksResult
    
    private enum CodingKeys: String, CodingKey {
        case topTracks = "toptracks"
    }
}

struct SBKUserGetTopTracksResult: Decodable, Sendable {
    let attributes: SBKUserGetTopAlbumsAttributes
    let tracks: [SBKTrack]
    
    private enum CodingKeys: String, CodingKey {
        case tracks = "track"
        case attributes = "@attr"
    }
}
