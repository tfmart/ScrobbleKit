//
//  SBKUserTagsResponse.swift
//  
//
//  Created by Tomas Martins on 17/06/23.
//

import Foundation

struct SBKUserTagsResponse: Decodable {
    var taggings: SBKUserTagsList
}

struct SBKUserTagsList: Decodable {
    var tracks: SBKUserTagsListResults?
    var albums: SBKUserTagsListResults?
    var artists: SBKUserTagsListResults?
    var attributes: SBKUserPersonalTagsAttributes
    
    enum CodingKeys: String, CodingKey {
        case tracks, albums, artists
        case attributes = "@attr"
    }
}

struct SBKUserTagsListResults: Decodable {
    var track: [SBKTrack]?
    var album: [SBKAlbum]?
    var artist: [SBKArtist]?
}
