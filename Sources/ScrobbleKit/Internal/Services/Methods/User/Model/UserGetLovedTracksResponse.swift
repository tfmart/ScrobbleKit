//
//  UserGetLovedTracksResponse.swift
//  
//
//  Created by Tomas Martins on 16/06/23.
//

import Foundation

struct _UserGetLovedTracksResponse: Decodable, Sendable {
    let lovedtracks: _UserLovedTracksList
}

struct _UserLovedTracksList: Decodable, Sendable {
    let track: [_UserLovedTrack]
    let attributes: _UserLovedTracksAttributes
    
    private enum CodingKeys: String, CodingKey {
        case track
        case attributes = "@attr"
    }
}

struct _UserLovedTrack: Decodable, Sendable {
    let artist: SBKArtist
    let date: SBKTimestamp
    let name: String
    let mbid: String?
    let url: String
    let image: [SBKImageResponse]
}

struct _UserLovedTracksAttributes: Decodable, Sendable {
    let user: String
    let totalPages: String
    let page: String
    let perPage: String
    let total: String
}
