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
