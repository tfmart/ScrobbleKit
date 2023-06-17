//
//  File.swift
//  
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

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
