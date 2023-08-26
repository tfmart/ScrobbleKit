//
//  SBKUserGetRecentTracksResponse.swift
//  
//
//  Created by Tomas Martins on 20/06/23.
//

import Foundation

struct SBKUserGetRecentTracksResponse: Decodable {
    var recenttracks: SBKUserGetRecentTracksResult
}

struct SBKUserGetRecentTracksResult: Decodable {
    let tracks: [SBKScrobbledTrack]
    let attributes: SBKUserGetRecentTracksAttributes
    
    private enum CodingKeys: String, CodingKey {
        case tracks = "track"
        case attributes = "@attr"
    }
    
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SBKUserGetRecentTracksResult.CodingKeys> = try decoder.container(keyedBy: SBKUserGetRecentTracksResult.CodingKeys.self)
        
        self.tracks = try container.decode([SBKScrobbledTrack].self, forKey: SBKUserGetRecentTracksResult.CodingKeys.tracks)
        self.attributes = try container.decode(SBKUserGetRecentTracksAttributes.self, forKey: SBKUserGetRecentTracksResult.CodingKeys.attributes)
        
    }
}

struct SBKUserGetRecentTracksAttributes: SBKSearchAttribute {
    var user: String
    var page: String
    var perPage: String
    var totalPages: String
    var total: String
}
