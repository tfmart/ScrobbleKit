//
//  SBKTrack.swift
//
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

/// Represents information about a track retrieved from Last.fm.
public struct SBKTrack: Decodable {
    /// The name of the track.
    public var name: String
    /// The MusicBrainz ID of the track, if available.
    public var mbid: String?
    /// The playcount of the track.
    public var playcount: Int?
    /// The number of listeners for the track.
    public var listeners: Int?
    /// The duration of the track.
    public var duration: String?
    /// The artist associated with the track.
    public var artist: SBKArtist
    /// The URL associated with the track.
    public var url: URL?
    /// The artwork image associated with the track.
    public var artwork: SBKImage?

    enum CodingKeys: String, CodingKey {
        case name
        case mbid
        case playcount
        case listeners
        case artist
        case imageList = "image"
    }
    
    internal init(name: String, mbid: String? = nil, playcount: String? = nil, listeners: String? = nil, duration: String? = nil, artist: SBKArtist, url: URL? = nil, imageList: [SBKImageResponse]? = nil) {
        self.name = name
        self.mbid = mbid
        self.playcount = Int(optionalString: playcount)
        self.listeners = Int(optionalString: listeners)
        self.duration = duration
        self.artist = artist
        self.url = url
        self.artwork = SBKImage(response: imageList)
    }
    
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SBKTrack.CodingKeys> = try decoder.container(keyedBy: SBKTrack.CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: SBKTrack.CodingKeys.name)
        self.mbid = try container.decodeIfPresent(String.self, forKey: SBKTrack.CodingKeys.mbid)
        self.playcount = try container.decodeIfPresent(IntegerStringDecoder.self, forKey: SBKTrack.CodingKeys.playcount)?.intValue
        self.listeners = try container.decodeIfPresent(IntegerStringDecoder.self, forKey: SBKTrack.CodingKeys.listeners)?.intValue
        if let artist = try? container.decode(SBKArtist.self, forKey: SBKTrack.CodingKeys.artist) {
            self.artist = artist
        } else {
            let aristString = try container.decode(String.self, forKey: SBKTrack.CodingKeys.artist)
            let artist = SBKArtist(name: aristString, playcount: nil, listeners: nil, musicBrainzID: nil, url: nil, streamable: nil, image: nil)
            self.artist = artist
        }
        if let imageList = try container.decodeIfPresent([SBKImageResponse].self, forKey: SBKTrack.CodingKeys.imageList) {
            self.artwork = SBKImage(response: imageList)
        }
        
    }
}
