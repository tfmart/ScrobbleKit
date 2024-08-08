//
//  SBKTaggedItem.swift
//  ScrobbleKit
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

/// Represents an item (track, artist, or album) that has been tagged.
public struct SBKTaggedItem: Decodable {
    /// The name of the item.
    public let name: String
    /// The Last.fm URL of the item.
    public let url: String
    /// The MusicBrainz ID of the item, if available.
    public let mbid: String?
    /// The artist associated with the item, if applicable.
    public let artist: SBKArtist?
    
    let imageResponse: [SBKImageResponse]?
    
    /// The image associated with the item, if available.
    public var image: SBKImage? {
        return .init(response: imageResponse)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case mbid
        case artist
        case imageResponse = "image"
    }
}
