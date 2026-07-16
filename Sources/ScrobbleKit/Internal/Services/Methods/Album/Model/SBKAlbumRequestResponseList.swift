//
//  SBKAlbumRequestResponseList.swift
//  
//
//  Created by Tomas Martins on 19/02/23.
//

import Foundation

struct SBKAlbumRequestResponseList: Decodable, Sendable {
    var album: SBKAlbum
}

// MARK: - Tags
struct SBKTagRequestResponse: Decodable, Sendable {
    var tags: SBKTagRequestResponseList
}

struct SBKTagRequestResponseList: Decodable, Sendable {
    var tag: [SBKTag]?
    
    enum CodingKeys: CodingKey {
        case tag
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let tagString = try? container.decodeIfPresent(String.self, forKey: .tag) {
            if tagString.isEmpty { self.tag = [] }
            else { self.tag = [.init(name: tagString)] }
        } else {
            self.tag = try container.decodeOneOrManyIfPresent(SBKTag.self, forKey: .tag)
        }
    }
    
    internal init(tag: [SBKTag]? = nil) {
        self.tag = tag
    }
}

// MARK: - Tracks
struct SBKAlbumTracksRequestResponseList: Decodable, Sendable {
    var track: [SBKAlbumTrack]
    
    enum CodingKeys: CodingKey {
        case track
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.track = try container.decodeOneOrMany(SBKAlbumTrack.self, forKey: .track)
    }
}

// MARK: - Track
struct SBKAlbumTrack: Codable, Sendable {
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
struct SBKAlbumTrackArtist: Codable, Sendable {
    var url: String
    var name: String
    var mbid: String
}

// MARK: - Attr
struct SBKAlbumTrackAttribute: Codable, Sendable {
    var rank: Int
}

// MARK: - Streamable
struct SBKAlbumTrackStreamable: Codable, Sendable {
    var fulltrack, text: String

    enum CodingKeys: String, CodingKey {
        case fulltrack
        case text = "#text"
    }
}
