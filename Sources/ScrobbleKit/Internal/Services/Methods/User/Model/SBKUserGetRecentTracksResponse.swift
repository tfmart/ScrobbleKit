//
//  SBKUserGetRecentTracksResponse.swift
//  
//
//  Created by Tomas Martins on 20/06/23.
//

import Foundation

struct SBKUserGetRecentTracksResponse: Decodable, Sendable {
    var recenttracks: SBKUserGetRecentTracksResult
}

struct SBKUserGetRecentTracksResult: Decodable, Sendable {
    let tracks: [SBKScrobbledTrack]
    let attributes: SBKUserGetRecentTracksAttributes
    
    private enum CodingKeys: String, CodingKey {
        case tracks = "track"
        case attributes = "@attr"
    }
    
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SBKUserGetRecentTracksResult.CodingKeys> = try decoder.container(keyedBy: SBKUserGetRecentTracksResult.CodingKeys.self)
        let trackList: [SBKThrowable<SBKScrobbledTrack>]
        if let tracks = try? container.decode([SBKThrowable<SBKScrobbledTrack>].self, forKey: .tracks) {
            trackList = tracks
        } else {
            let track = try container.decode(SBKThrowable<SBKScrobbledTrack>.self, forKey: .tracks)
            trackList = [track]
        }
        self.tracks = trackList.compactMap { $0.object }
        self.attributes = try container.decode(SBKUserGetRecentTracksAttributes.self, forKey: .attributes)
        
    }
}

struct SBKUserGetRecentTracksAttributes: SBKSearchAttribute {
    var user: String
    var page: String
    var perPage: String
    var totalPages: String
    var total: String
}
