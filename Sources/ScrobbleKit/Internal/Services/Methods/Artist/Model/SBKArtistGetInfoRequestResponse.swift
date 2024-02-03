//
//  SBKArtistGetInfoRequestResponse.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

struct SBKArtistGetInfoRequestResponse: Decodable {
    var artist: SBKArtistGetInfoProperties
}

struct SBKArtistGetInfoProperties: Decodable {
    var name: String
    var mbid: String?
    var image: [SBKImageResponse]?
    var url: String
    var streamable: String?
    var ontour: String?
    var stats: SBKArtistGetInfoPropertiesStats?
    var similar: SBKArtistGetInfoSimilarResponse?
    var tags: SBKTagRequestResponseList?
    var bio: SBKWiki?
}

struct SBKArtistGetInfoPropertiesStats: Decodable {
    var listeners: String
    var playcount: String
}

struct SBKArtistGetInfoSimilarResponse: Decodable {
    var artist: [SBKArtistGetInfoSimilarArtist]
    
    var sbkArtist: [SBKArtist] {
        return artist.map { SBKArtist(similarArtist: $0) }
    }
}
