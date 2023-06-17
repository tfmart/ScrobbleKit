//
//  SBKAlbumRequestResponseList.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

struct SBKAlbumRequestResponseList: Decodable {
    var album: SBKAlbum
}

// MARK: - Tags
struct SBKTagRequestResponse: Decodable {
    var tags: SBKTagRequestResponseList
}

struct SBKTagRequestResponseList: Decodable {
    var tag: [SBKTag]?
}

// MARK: - Tracks
struct SBKAlbumTracksRequestResponseList: Codable {
    var track: [SBKAlbumTrack]
}

// MARK: - Track
struct SBKAlbumTrack: Codable {
    var streamable: SBKAlbumTrackStreamable
    var duration: Int?
    var url: String
    var name: String
    var attr: SBKAlbumTrackAttribute
    var artist: SBKAlbumTrackArtist

    enum CodingKeys: String, CodingKey {
        case streamable, duration, url, name
        case attr = "@attr"
        case artist
    }
}

// MARK: - ArtistClass
struct SBKAlbumTrackArtist: Codable {
    var url: String
    var name: String
    var mbid: String
}

// MARK: - Attr
struct SBKAlbumTrackAttribute: Codable {
    var rank: Int
}

// MARK: - Streamable
struct SBKAlbumTrackStreamable: Codable {
    var fulltrack, text: String

    enum CodingKeys: String, CodingKey {
        case fulltrack
        case text = "#text"
    }
}
