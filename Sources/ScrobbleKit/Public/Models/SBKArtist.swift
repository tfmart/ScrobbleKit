//
//  SBKArtist.swift
//
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

public struct SBKArtist: Decodable {
    let name: String
    let playcount: String?
    let listeners: String?
    let musicBrainzID: String?
    let url: String?
    let streamable: String?
    internal let image: [SBKImageResponse]?
    internal let artistText: String?
    
    var images: SBKImage? {
        guard let image else { return nil }
        return SBKImage(response: image)
    }
    
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
        self.image = try container.decodeIfPresent([SBKImageResponse].self, forKey: SBKArtist.CodingKeys.image)
    }
    
    internal init(name: String, playcount: String? = nil, listeners: String? = nil, musicBrainzID: String? = nil, url: String? = nil, streamable: String? = nil, image: [SBKImageResponse]? = nil, artistText: String? = nil) {
        self.name = name
        self.playcount = playcount
        self.listeners = listeners
        self.musicBrainzID = musicBrainzID
        self.url = url
        self.streamable = streamable
        self.image = image
        self.artistText = artistText
    }
}
