//
//  SBKUserGetTopAlbumsResponse.swift
//  
//
//  Created by Tomas Martins on 20/06/23.
//

import Foundation

struct SBKUserGetTopAlbumsResponse: Decodable {
    let topAlbums: SBKUserGetTopAlbumsResult
    
    private enum CodingKeys: String, CodingKey {
        case topAlbums = "topalbums"
    }
}

struct SBKUserGetTopAlbumsResult: Decodable {
    let attributes: SBKUserGetTopAlbumsAttributes
    let albums: [SBKAlbum]
    
    private enum CodingKeys: String, CodingKey {
        case albums = "album"
        case attributes = "@attr"
    }
}

struct SBKUserGetTopAlbumsAttributes: SBKSearchAttribute {
    var user: String
    var page: String
    var perPage: String
    var totalPages: String
    var total: String
}