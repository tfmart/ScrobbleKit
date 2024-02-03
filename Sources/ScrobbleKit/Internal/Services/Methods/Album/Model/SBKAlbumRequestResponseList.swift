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
    
    enum CodingKeys: CodingKey {
        case tag
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let tagString = try? container.decodeIfPresent(String.self, forKey: .tag) {
            if tagString.isEmpty { self.tag = [] }
            else { self.tag = [.init(name: tagString)] }
        } else {
            self.tag = try container.decodeIfPresent([SBKTag].self, forKey: .tag)
        }
    }
    
    internal init(tag: [SBKTag]? = nil) {
        self.tag = tag
    }
}

// MARK: - Tracks
struct SBKAlbumTracksRequestResponseList: Decodable {
    var track: [SBKAlbumTrack]
    
    enum CodingKeys: CodingKey {
        case track
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let track = try? container.decode(SBKAlbumTrack.self, forKey: .track) {
            self.track = [track]
        } else {
            self.track = try container.decode([SBKAlbumTrack].self, forKey: .track)
        }
    }
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
