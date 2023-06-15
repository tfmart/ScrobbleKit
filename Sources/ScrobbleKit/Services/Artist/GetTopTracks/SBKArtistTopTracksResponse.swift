//
//  SBKArtistTopTracksResponse.swift
//  
//
//  Created by Tomas Martins on 23/02/23.
//

import Foundation

struct SBKArtistTopTracksResponse: Decodable {
    var toptracks: SBKArtistTopTracksList
}

struct SBKArtistTopTracksList: Decodable {
    var track: [SBKTrack]
}

public struct SBKTrack: Decodable {
    internal init(name: String, mbid: String? = nil, playcount: String? = nil, listeners: String? = nil, duration: String? = nil, artist: SBKArtist, url: URL? = nil, imageList: [SBKImageResponse]? = nil) {
        self.name = name
        self.mbid = mbid
        self.playcount = playcount
        self.listeners = listeners
        self.duration = duration
        self.artist = artist
        self.url = url
        self.imageList = imageList
    }
    
    public var name: String
    public var mbid: String?
    public var playcount: String?
    public var listeners: String?
    public var duration: String?
    public var artist: SBKArtist
    public var url: URL?
    internal var imageList: [SBKImageResponse]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case mbid
        case playcount
        case listeners
        case artist
        case imageList = "image"
    }
    
    public var images: SBKImage? {
        return SBKImage(response: imageList)
    }
    
    
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SBKTrack.CodingKeys> = try decoder.container(keyedBy: SBKTrack.CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: SBKTrack.CodingKeys.name)
        self.mbid = try container.decodeIfPresent(String.self, forKey: SBKTrack.CodingKeys.mbid)
        self.playcount = try container.decodeIfPresent(String.self, forKey: SBKTrack.CodingKeys.playcount)
        self.listeners = try container.decodeIfPresent(String.self, forKey: SBKTrack.CodingKeys.listeners)
        if let artist = try? container.decode(SBKArtist.self, forKey: SBKTrack.CodingKeys.artist) {
            self.artist = artist
        } else {
            let aristString = try container.decode(String.self, forKey: SBKTrack.CodingKeys.artist)
            let artist = SBKArtist(name: aristString, playcount: nil, listeners: nil, musicBrainzID: nil, url: nil, streamable: nil, image: nil)
            self.artist = artist
        }
        self.imageList = try container.decodeIfPresent([SBKImageResponse].self, forKey: SBKTrack.CodingKeys.imageList)
        
    }
}
