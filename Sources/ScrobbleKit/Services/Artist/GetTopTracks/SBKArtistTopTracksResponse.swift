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
    public var name: String
    public var mbid: String?
    public var playcount: String?
    public var listeners: String?
    public var duration: String?
    public var artist: SBKArtist
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
}
