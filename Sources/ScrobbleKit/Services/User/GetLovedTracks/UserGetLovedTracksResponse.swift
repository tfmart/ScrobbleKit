//
//  UserGetLovedTracksResponse.swift
//  
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

struct _UserGetLovedTracksResponse: Decodable {
    let lovedtracks: _UserLovedTracksList
}

struct _UserLovedTracksList: Decodable {
    let track: [_UserLovedTrack]
    let attributes: _UserLovedTracksAttributes
    
    private enum CodingKeys: String, CodingKey {
        case track
        case attributes = "@attr"
    }
}

struct _UserLovedTrack: Decodable {
    let artist: SBKArtist
    let date: _UserLovedTrackDate
    let name: String
    let mbid: String?
    let url: String
    let image: [SBKImageResponse]
}

struct _UserLovedTrackDate: Decodable {
    let timestamp: String
    let date: String
    
    private enum CodingKeys: String, CodingKey {
        case timestamp = "uts"
        case date = "#text"
    }
}

struct _UserLovedTracksAttributes: Decodable {
    let user: String
    let totalPages: String
    let page: String
    let perPage: String
    let total: String
}

public struct SBKLovedTracks {
    let searchAttributes: SBKSearchAttributes
    let tracks: [SBKLovedTrack]
    
    internal init(from response: _UserGetLovedTracksResponse) {
        let responseAttributes = response.lovedtracks.attributes
        self.searchAttributes = SBKSearchAttributes(
            term: responseAttributes.user,
            totalPages: responseAttributes.total,
            page: responseAttributes.page,
            perPage: responseAttributes.perPage,
            total: responseAttributes.total
        )
        
        let responseTrackList = response.lovedtracks.track
        self.tracks = responseTrackList.map {
            let track = SBKTrack(
                name: $0.name,
                mbid: $0.mbid,
                playcount: nil,
                listeners: nil,
                duration: nil,
                artist: $0.artist,
                url: URL(string: $0.url),
                imageList: $0.image
            )
            
            var date: Date? = nil
            
            if let timeInterval = TimeInterval($0.date.timestamp) {
                date = Date(timeIntervalSince1970: timeInterval)
            }
            
            return SBKLovedTrack(track: track, date: date)
        }
    }
}

public struct SBKLovedTrack {
    let track: SBKTrack
    let date: Date?
}

public struct SBKSearchAttributes {
    let term: String
    let totalPages: String
    let page: String
    let perPage: String
    let total: String
}
