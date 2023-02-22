//
//  File.swift
//  
//
//  Created by Tomas Martins on 22/02/23.
//

import Foundation

struct SBKArtistGetInfoRequestResponse: Decodable {
    var artist: SBKArtistGetInfoProperties
}

struct SBKArtistGetInfoProperties: Decodable {
    var artist: String
    var mbid: String?
    var image: [SBKImageResponse]?
    var url: String
    var streamable: Int?
    var ontour: Int?
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
}
