//
//  SBKAlbum.swift
//  
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

/// Represents information from an album in Last.fm, providing details such as name, artist, playcount, and tags.
public struct SBKAlbum: Decodable {
    /// The name of the album.
    public var name: String
    /// The artist associated with the album.
    public var artist: String
    /// The MusicBrainz ID of the album, if available.
    public var musicBrainzID: String?
    /// The playcount of the album.
    public var playcount: String?
    /// The URL of the album on Last.fm.
    public var url: String?
    /// The number of listeners for the album.
    public var listeners: String?
    /// The wiki information associated with the album.
    public var wiki: SBKWiki?
    
    internal var image: [SBKImageResponse]?
    internal var tracks: SBKAlbumTracksRequestResponseList?
    internal var tagList: SBKTagRequestResponseList?
    
    enum CodingKeys: String, CodingKey {
        case artist
        case name
        case musicBrainzID = "mbid"
        case tagList = "tags"
        case playcount
        case image
        case tracks
        case url
        case listeners
        case wiki
    }
    
    /// The artwork of the album.
    public var artwork: SBKImage? {
        guard let image else { return nil }
        return SBKImage(response: image)
    }
    
    /// The list of tags associated with the album.
    public var tags: [SBKTag] {
        guard let tagList,
              let tags = tagList.tag else { return [] }
        return tags
    }
    
    /// The list of tracks associated with the album.
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
        self.musicBrainzID = topAlbumArtist.mbid
        self.playcount = "\(topAlbumArtist.playcount)"
        self.image = topAlbumArtist.image
        
        self.tagList = nil
        self.wiki = nil
    }
    
    internal init(albumResponse: SBKAlbumRequestResponseList) {
        self = albumResponse.album
    }
    
    
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SBKAlbum.CodingKeys> = try decoder.container(keyedBy: SBKAlbum.CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: SBKAlbum.CodingKeys.name)
        self.musicBrainzID = try container.decodeIfPresent(String.self, forKey: SBKAlbum.CodingKeys.musicBrainzID)
        self.playcount = try container.decodeIfPresent(String.self, forKey: SBKAlbum.CodingKeys.playcount)
        self.image = try container.decodeIfPresent([SBKImageResponse].self, forKey: SBKAlbum.CodingKeys.image)
        self.tracks = try container.decodeIfPresent(SBKAlbumTracksRequestResponseList.self, forKey: SBKAlbum.CodingKeys.tracks)
        self.url = try container.decodeIfPresent(String.self, forKey: SBKAlbum.CodingKeys.url)
        self.listeners = try container.decodeIfPresent(String.self, forKey: SBKAlbum.CodingKeys.listeners)
        self.wiki = try container.decodeIfPresent(SBKWiki.self, forKey: SBKAlbum.CodingKeys.wiki)
        
        if let artist = try? container.decode(String.self, forKey: SBKAlbum.CodingKeys.artist) {
            self.artist = artist
        } else {
            let artist = try container.decode(SBKArtist.self, forKey: SBKAlbum.CodingKeys.artist)
            self.artist = artist.name
        }
        
        if let tagString = try? container.decodeIfPresent(String.self, forKey: .tagList) {
            if tagString.isEmpty { self.tagList = nil }
            else { self.tagList =  .init(tag: [.init(name: tagString)] )}
        } else {
            self.tagList = try container.decodeIfPresent(SBKTagRequestResponseList.self, forKey: SBKAlbum.CodingKeys.tagList)
        }
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
