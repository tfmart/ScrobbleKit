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

public enum SBKSearchTerms {
    case artist
    case user
    case tag
    case album
    case track
}

public struct SBKSearchResult<Model: Decodable> {
    public var results: [Model]
    public var searchTerms: [SBKSearchTerms: String]
    
    public var page: Int
    public var perPage: Int
    public var totalPages: Int
    public var total: Int
}
