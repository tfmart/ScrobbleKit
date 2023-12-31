//
//  SBKArtist.swift
//
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

/// Represents information about an artist retrieved from Last.fm, providing details such as name, playcount, and images.
public struct SBKArtist: Decodable {
    /// The name of the artist.
    public let name: String
    /// The playcount of the artist.
    public let playcount: String?
    /// The number of listeners for the artist.
    public let listeners: String?
    /// The MusicBrainz ID of the artist, if available.
    public let musicBrainzID: String?
    /// The URL associated with the artist.
    public let url: String?
    /// An image of the artist, if available.
    public var image: SBKImage?
    public let streamable: String?
    internal let artistText: String?
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case playcount
        case listeners
        case musicBrainzID = "mbid"
        case url
        case streamable
        case image
        case artistText = "#text"
    }
    
    
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SBKArtist.CodingKeys> = try decoder.container(keyedBy: SBKArtist.CodingKeys.self)
        if let name = try? container.decode(String.self, forKey: SBKArtist.CodingKeys.name) {
            self.name = name
            self.artistText = nil
        } else {
            let artistText = try container.decode(String.self, forKey: SBKArtist.CodingKeys.artistText)
            self.artistText = artistText
            self.name = artistText
        }
        
        self.playcount = try container.decodeIfPresent(String.self, forKey: SBKArtist.CodingKeys.playcount)
        self.listeners = try container.decodeIfPresent(String.self, forKey: SBKArtist.CodingKeys.listeners)
        self.musicBrainzID = try container.decodeIfPresent(String.self, forKey: SBKArtist.CodingKeys.musicBrainzID)
        self.url = try container.decodeIfPresent(String.self, forKey: SBKArtist.CodingKeys.url)
        self.streamable = try container.decodeIfPresent(String.self, forKey: SBKArtist.CodingKeys.streamable)
        if let imageResponse = try container.decodeIfPresent([SBKImageResponse].self, forKey: SBKArtist.CodingKeys.image) {
            self.image = SBKImage(response: imageResponse)
        }
    }
    
    internal init(name: String, playcount: String? = nil, listeners: String? = nil, musicBrainzID: String? = nil, url: String? = nil, streamable: String? = nil, image: [SBKImageResponse]? = nil, artistText: String? = nil) {
        self.name = name
        self.playcount = playcount
        self.listeners = listeners
        self.musicBrainzID = musicBrainzID
        self.url = url
        self.streamable = streamable
        self.image = SBKImage(response: image)
        self.artistText = artistText
    }
}
