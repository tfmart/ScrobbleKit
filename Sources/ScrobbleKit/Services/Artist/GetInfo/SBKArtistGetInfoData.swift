//
//  SBKArtistGetInfoData.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

/// Represents the response from the `artist.getInfo` method.
public struct SBKArtistGetInfoData {
    /// The artist name.
    public var name: String
    /// The artist's URL on Last.fm.
    public var url: String
    /// The MusicBrainz ID for the artist.
    public var musicBrainzID: String?
    /// An image for the artist.
    public var image: SBKImage?
    /// A flag indicating whether the artist is currently on tour.
    public var isOnTour: Bool?
    /// The number of listeners for the artist on Last.fm.
    public var listeners: Int?
    /// The number of times the artist's tracks have been played on Last.fm.
    public var playCount: Int?
    /// The tags associated with the artist.
    public var tags: [SBKTag]?
    /// The Wikipedia content for the artist.
    public var wiki: SBKWiki?
    /// The list of similar artists for the artist.
    public var similarArtists: [SBKArtistGetInfoSimilarArtist]?
    
    internal init(response: SBKArtistGetInfoRequestResponse) {
        self.name = response.artist.name
        self.url = response.artist.url
        self.musicBrainzID = response.artist.mbid
        self.image = .init(response: response.artist.image)
        self.wiki = response.artist.bio
        self.tags = response.artist.tags?.tag
        self.similarArtists = response.artist.similar?.artist
        
        if let ontour = response.artist.ontour, let onTourInt = Int(ontour) {
            self.isOnTour = Bool(integer: onTourInt)
        } else {
            self.isOnTour = nil
        }
        
        if let stats = response.artist.stats {
            self.listeners = Int(stats.listeners)
            self.playCount = Int(stats.playcount)
        } else {
            self.listeners = nil
            self.playCount = nil
        }
    }
}

/// Represents a similar artist for an artist.
public struct SBKArtistGetInfoSimilarArtist: Decodable {
    /// The name of the similar artist.
    public var name: String
    /// The URL of the similar artist on Last.fm.
    public var url: String
    private var imageResponse: [SBKImageResponse]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case imageResponse = "image"
    }
    
    /// An image for the similar artist.
    public var image: SBKImage? {
        return .init(response: imageResponse)
    }
}
