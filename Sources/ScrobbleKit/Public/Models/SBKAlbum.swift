//
//  File.swift
//  
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

public struct SBKAlbum: Decodable {
    public var name: String
    public var artist: String
    public var mbid: String?
    internal var tagList: SBKTagRequestResponseList?
    public var playcount: String?
    internal var image: [SBKImageResponse]?
    internal var tracks: SBKAlbumTracksRequestResponseList?
    public var url: String?
    public var listeners: String?
    public var wiki: SBKWiki?
    
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
    
    public var images: SBKImage? {
        guard let image else { return nil }
        return SBKImage(response: image)
    }
    
    public var tags: [SBKTag] {
        guard let tagList,
              let tags = tagList.tag else { return [] }
        return tags
    }
    
    public var tracklist: [SBKTrack] {
        guard let tracks = tracks?.track else { return [] }
        return tracks.map { track in
            let url = URL(string: track.url)
            
            var duration: String? {
                guard let duration = track.duration else {
                    return nil
                }
                return String(duration)
            }
            
            return SBKTrack(name: track.name,
                     mbid: nil,
                     playcount: nil,
                     listeners: nil,
                     duration: duration,
                     artist: .init(name: track.artist.name, musicBrainzID: track.artist.mbid, url: track.artist.url),
                     url: url,
                     imageList: nil)
        }
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
