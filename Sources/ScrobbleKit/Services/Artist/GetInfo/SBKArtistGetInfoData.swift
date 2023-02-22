//
//  File.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

public struct SBKArtistGetInfoData {
    public var name: String
    public var url: String
    public var musicBrainzID: String?
    public var image: SBKImage?
    public var isOnTour: Bool?
    public var listeners: Int?
    public var playCount: Int?
    public var tags: [SBKTag]?
    public var wiki: SBKWiki?
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

public struct SBKArtistGetInfoSimilarArtist: Decodable {
    public var name: String
    public var url: String
    private var imageResponse: [SBKImageResponse]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case imageResponse = "image"
    }
    
    public var image: SBKImage? {
        return .init(response: imageResponse)
    }
}
