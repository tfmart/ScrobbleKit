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
    public var playcount: String
    public var listeners: String
    internal var imageList: [SBKImageResponse]?
    internal var artistData: SBKAlbumTrackArtist
    
    enum CodingKeys: String, CodingKey {
        case name
        case mbid
        case playcount
        case listeners
        case artistData = "artist"
        case imageList = "image"
    }
    
    public var images: SBKImage? {
        return SBKImage(response: imageList)
    }
    
    public var artist: String {
        return artistData.name
    }
}
