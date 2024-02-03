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
    public let playcount: Int?
    /// The number of listeners for the artist.
    public let listeners: Int?
    /// The MusicBrainz ID of the artist, if available.
    public let musicBrainzID: UUID?
    /// The URL associated with the artist.
    public let url: URL?
    /// An image of the artist, if available.
    public var image: SBKImage?
    /// A flag indicating whether the artist is currently on tour.
    public var isOnTour: Bool?
    /// The tags associated with the artist.
    public var tags: [SBKTag]?
    /// The Wikipedia content for the artist.
    public var wiki: SBKWiki?
    /// The list of similar artists for the artist.
    public var similarArtists: [SBKArtist]?
    
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
        
        self.playcount = try container.decodeIfPresent(IntegerStringDecoder.self, forKey: SBKArtist.CodingKeys.playcount)?.intValue
        self.listeners = try container.decodeIfPresent(IntegerStringDecoder.self, forKey: SBKArtist.CodingKeys.listeners)?.intValue
        self.musicBrainzID = UUID(optionalString: try container.decodeIfPresent(String.self, forKey: SBKArtist.CodingKeys.musicBrainzID))
        self.url = try container.decodeIfPresent(URL.self, forKey: SBKArtist.CodingKeys.url)
        self.streamable = try container.decodeIfPresent(String.self, forKey: SBKArtist.CodingKeys.streamable)
        if let imageResponse = try container.decodeIfPresent([SBKImageResponse].self, forKey: SBKArtist.CodingKeys.image) {
            self.image = SBKImage(response: imageResponse)
        }
    }
    
    internal init(name: String, playcount: String? = nil, listeners: String? = nil, musicBrainzID: String? = nil, url: String? = nil, streamable: String? = nil, image: [SBKImageResponse]? = nil, artistText: String? = nil) {
        self.name = name
        self.playcount = Int(optionalString: playcount)
        self.listeners = Int(optionalString: listeners)
        self.musicBrainzID = UUID(optionalString: musicBrainzID)
        self.url = URL(optionalString: url)
        self.streamable = streamable
        self.image = SBKImage(response: image)
        self.artistText = artistText
    }
    
    internal init(getInfoData: SBKArtistGetInfoRequestResponse) {
        self.name = getInfoData.artist.name
        self.playcount = Int(optionalString: getInfoData.artist.stats?.playcount)
        self.listeners = Int(optionalString: getInfoData.artist.stats?.listeners)
        self.musicBrainzID = UUID(optionalString: getInfoData.artist.mbid)
        self.url = URL(optionalString: getInfoData.artist.url)
        self.streamable = getInfoData.artist.streamable
        self.image = SBKImage(response: getInfoData.artist.image)
        self.tags = getInfoData.artist.tags?.tag
        self.wiki = getInfoData.artist.bio
        self.similarArtists = getInfoData.artist.similar?.sbkArtist
        self.artistText = nil
        
        if let onTourInt = Int(optionalString: getInfoData.artist.ontour) {
            self.isOnTour = Bool(integer: onTourInt)
        } else {
            self.isOnTour = nil
        }
    }
    
    internal init(similarArtist: SBKArtistGetInfoSimilarArtist) {
        self.name = similarArtist.name
        self.url = URL(string: similarArtist.url)
        self.image = similarArtist.image
        self.playcount = nil
        self.listeners = nil
        self.musicBrainzID = nil
        self.streamable = nil
        self.artistText = nil
    }
}
