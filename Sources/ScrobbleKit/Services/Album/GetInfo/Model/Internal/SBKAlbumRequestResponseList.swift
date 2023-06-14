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

// MARK: - Album
public struct SBKAlbum: Decodable {
    var artist, name: String
    var mbid: String?
    internal var tagList: SBKTagRequestResponseList?
    var playcount: String?
    internal var image: [SBKImageResponse]?
    var tracks: SBKAlbumTracksRequestResponseList?
    var url: String?
    var listeners: String?
    var wiki: SBKWiki?
    
    enum CodingKeys: String, CodingKey {
        case artist
        case name
        case mbid
        case tagList = "tags"
        case playcount
        case image
        case tracks
        case url
        case listeners
        case wiki
    }
    
    var images: SBKImage? {
        guard let image else { return nil }
        return SBKImage(response: image)
    }
    
    var tags: [SBKTag] {
        guard let tagList,
              let tags = tagList.tag else { return [] }
        return tags
    }
    
    internal init(topAlbumArtist: SBKArtistTopAlbum) {
        self.artist = topAlbumArtist.artist.name
        self.name = topAlbumArtist.name
        self.url = topAlbumArtist.url
        self.mbid = topAlbumArtist.mbid
        self.playcount = "\(topAlbumArtist.playcount)"
        self.image = topAlbumArtist.image
        
        self.tagList = nil
        self.wiki = nil
    }
}

// MARK: - Image
struct SBKImageResponse: Codable {
    var size: String
    var text: String

    enum CodingKeys: String, CodingKey {
        case size
        case text = "#text"
    }
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
